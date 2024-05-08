import { htmlSafe } from "@ember/template";
import { renderAvatar } from "discourse/helpers/user-avatar";
import { registerRawHelper } from "discourse-common/lib/helpers";

registerRawHelper("excerpt-avatar-latest", excerptAvatarLatest);

export function excerptAvatarLatest(featuredUsers) {
  if (!featuredUsers || !featuredUsers.length) {
    return "";
  }
  for (let i = 0; i < featuredUsers.length; i++) {
    if (featuredUsers[i].extras && featuredUsers[i].extras.includes("latest")) {
      return htmlSafe(
        renderAvatar(featuredUsers[i], {
          avatarTemplatePath: "user.avatar_template",
          usernamePath: "user.username",
          namePath: "user.name",
          imageSize: 18,
        })
      );
    }
  }
}
