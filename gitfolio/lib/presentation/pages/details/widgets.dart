part of 'package:gitfolio/presentation/pages/details/details_page.dart';

class _UserImage extends StatelessWidget {
  final String url;

  const _UserImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.8,
        height: MediaQuery.sizeOf(context).width * 0.8,
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.all(Radius.circular(AppDimensions.bigRadius)),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _TextInformation extends StatelessWidget {
  final String name;
  final String? value;

  const _TextInformation({required this.name, this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$name: ',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppFonts.titleLarge,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: value ?? AppStrings.undefined,
            style: TextStyle(
              fontStyle: value == null ? FontStyle.italic : FontStyle.normal,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _Organizations extends StatelessWidget {
  final List<GithubOrganization> organizations;

  const _Organizations({required this.organizations});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.middleMargin,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: organizations.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const _Title();
          }
          final organization = organizations[index - 1];
          return ImageListTile(
            imageUrl: organization.avatarUrl,
            title: organization.login,
            subtitle: organization.description == null ||
                    organization.description == ''
                ? AppStrings.noDescription
                : organization.description!,
            isItalicSubtitle: organization.description == null ||
                organization.description == '',
          );
        },
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        left: AppDimensions.middleMargin,
      ),
      child: Text(
        AppStrings.organizations,
        style: TextStyle(
          fontSize: AppFonts.headlineSmall,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
