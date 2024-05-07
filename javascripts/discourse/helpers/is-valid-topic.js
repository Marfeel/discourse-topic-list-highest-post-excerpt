import { registerRawHelper } from 'discourse-common/lib/helpers';

registerRawHelper('isValidTopic', function(category, isPrivateMessage) {
	if (isPrivateMessage) {
		return settings.private_messages;
	}

	const array = settings.categories.split('|')
		.filter((id) => id !== '')
		.map((id) => parseInt(id, 10))
		.filter((id) => id);

	return array.length === 0 || array.includes(category);
});