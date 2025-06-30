import { helper } from "@ember/component/helper";

export default helper(function isValidTopic([category, isPrivateMessage]) {
  if (isPrivateMessage) {
    return settings.private_messages;
  }

  const array = settings.categories
    .split("|")
    .filter((id) => id !== "")
    .map((id) => Number.parseInt(id, 10))
    .filter((id) => id);

  return array.includes(category);
});
