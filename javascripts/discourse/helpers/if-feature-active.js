import { registerRawHelper } from "discourse/lib/helpers";

registerRawHelper("isFeatureActive", (feature, isPrivateMessage) => {
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
