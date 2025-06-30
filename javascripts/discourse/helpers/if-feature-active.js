import { helper } from "@ember/component/helper";

export default helper(function isFeatureActive([feature, isPrivateMessage]) {
  if (!["show_avatars", "show_reply_icon"].includes(feature)) {
    return false;
  }
  const config = settings[feature];

  switch (config) {
    case "all":
      return true;
    case "topics":
      return !isPrivateMessage;
    case "messages":
      return isPrivateMessage;
    default:
      return false;
  }
});
