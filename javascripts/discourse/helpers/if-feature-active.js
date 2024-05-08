import { registerRawHelper } from 'discourse-common/lib/helpers';

registerRawHelper('isFeatureActive', function(feature, isPrivateMessage) {
	if (!['show_avatars', 'show_reply_icon'].includes(feature)) {
		return false;
	}
	const config = settings[feature];

	switch (config) {
		case 'all':
			return true;
		case 'topics':
			return !isPrivateMessage;
		case 'messages':
			return isPrivateMessage;
		case 'none':
		default:
			return false;
	}
});