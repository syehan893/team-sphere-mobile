import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:team_sphere_mobile/app/themes/colors.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';

import '../../../data/data.dart';
import '../../cubits/cubit.dart';
import '../../widgets/widgets.dart';

class ReimbursementDetailModal extends StatefulWidget {
  final ScrollController controller;
  final ReimbursementRequest reimbursement;

  const ReimbursementDetailModal({
    super.key,
    required this.controller,
    required this.reimbursement,
  });

  @override
  ReimbursementDetailModalState createState() =>
      ReimbursementDetailModalState();
}

class ReimbursementDetailModalState extends State<ReimbursementDetailModal> {
  @override
  Widget build(BuildContext context) {
    context.read<CreateReimbursementRequestCubit>().downloadFile(
        '${widget.reimbursement.employeeId}/${widget.reimbursement.receiptFilePath}');
    return SingleChildScrollView(
      controller: widget.controller,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            H2(widget.reimbursement.description, textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Body1.regular(
                'Rp.${Util.formatNumber(widget.reimbursement.amount)}',
                fontSize: 18),
            const SizedBox(height: 10),
            Button(
              title: widget.reimbursement.expenseType,
              onTap: () {},
              height: 48,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    DetailItem(
                        label: 'ID',
                        value: widget.reimbursement.requestId.toString()),
                    DetailItem(
                        label: 'Invoice Date',
                        value: Util.formatDateFullVersion(
                            widget.reimbursement.expenseDate.toString())),
                    DetailItem(
                        label: 'Submitted Date',
                        value: Util.formatDateFullVersion(
                            widget.reimbursement.requestDate.toString())),
                    const SizedBox(height: 20),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            if (widget.reimbursement.receiptFilePath.isNotEmpty) ...[
              _buildFilePreview(),
            ] else
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(Icons.image, size: 50, color: Colors.grey[400]),
                ),
              ),
            const SizedBox(height: 54),
            Row(
              children: [
                Expanded(
                  child: Button(
                    title: 'Reject',
                    backgroundColor: TSColors.alert.red700,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Button(
                    title: 'Approve',
                    backgroundColor: TSColors.alert.green700,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilePreview() {
    return BlocBuilder<CreateReimbursementRequestCubit,
        CreateReimbursementRequestState>(
      builder: (context, state) {
        if (state.downloadFileStatus == FetchStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.progressiveDots(
              color: TSColors.primary.p100,
              size: 50,
            ),
          );
        }
        if (state.downloadFileStatus == FetchStatus.loaded) {
          final filePublicUrl = state.filePublicUrl!;
          final String fileName =
              widget.reimbursement.receiptFilePath.split('/').last;

          return GestureDetector(
            onTap: () async {
              await downloadFile(filePublicUrl, fileName);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                fileName,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: TSColors.primary.p100,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          );
        } else {
          return const Center(child: Text("Failed to load file"));
        }
      },
    );
  }

  Future<void> downloadFile(String filePublicUrl, String fileName) async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      status = await Permission.storage.request();
    }

    FileDownloader.downloadFile(
      url: filePublicUrl,
      downloadDestination: DownloadDestinations.publicDownloads,
      name: fileName,
      onProgress: (fileName, progress) {},
      onDownloadCompleted: (fileName) {
        CustomToast.showToast(
            context, 'Download completed: $fileName', TSColors.alert.green700);
        Navigator.pop(context);
      },
      onDownloadError: (error) {
        CustomToast.showToast(
            context, 'Download failed: $fileName', TSColors.alert.red700);
        Navigator.pop(context);
      },
    );
  }
}

class DetailItem extends StatelessWidget {
  final String label;
  final String value;

  const DetailItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Body1.regular('$label : $value', fontSize: 14),
    );
  }
}
