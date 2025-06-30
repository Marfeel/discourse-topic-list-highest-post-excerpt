import { htmlSafe } from "@ember/template";
import { renderAvatar } from "discourse/helpers/user-avatar";
import { registerRawHelper } from "discourse/lib/helpers";

registerRawHelper("excerpt-avatar-creator", excerptAvatarCreator);

export function excerptAvatarCreator(featuredUsers) {
  if (!featuredUsers || !featuredUsers.length) {
    return "";
  }
  if (featuredUsers?.length) {
    return htmlSafe(
      renderAvatar(featuredUsers[0], {
        avatarTemplatePath: "user.avatar_template",
        usernamePath: "user.username",
        namePath: "user.name",
        imageSize: 18,
      })
    );
  }
}
