import { helper } from "@ember/component/helper";
import { htmlSafe } from "@ember/template";
import { renderAvatar } from "discourse/helpers/user-avatar";

export default helper(function excerptAvatarCreator([featuredUsers]) {
  if (!featuredUsers || !featuredUsers.length) {
    return htmlSafe("");
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
  return htmlSafe("");
});
