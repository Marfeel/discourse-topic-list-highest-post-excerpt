import { helper } from "@ember/component/helper";
import { htmlSafe } from "@ember/template";
import { renderAvatar } from "discourse/helpers/user-avatar";

export default helper(function excerptAvatarLatest([featuredUsers]) {
  if (!featuredUsers || !featuredUsers.length) {
    return htmlSafe("");
  }
  for (let i = 0; i < featuredUsers.length; i++) {
    if (featuredUsers[i].extras?.includes("latest")) {
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
  return htmlSafe("");
});
