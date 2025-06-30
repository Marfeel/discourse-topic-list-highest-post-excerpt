import Component from "@glimmer/component";
import { service } from "@ember/service";
import { htmlSafe } from "@ember/template";
import dIcon from "discourse/helpers/d-icon";
import dirSpan from "discourse/helpers/dir-span";
import { renderAvatar } from "discourse/helpers/user-avatar";

export default class HighestPostExcerpt extends Component {
  @service siteSettings;

  get shouldShowExcerpt() {
    const topic = this.args.outletArgs.topic;
    return topic?.highest_post_excerpt && this.isValidTopic(topic);
  }

  isValidTopic(topic) {
    if (topic.isPrivateMessage) {
      return settings.private_messages;
    }

    const array = settings.categories
      .split("|")
      .filter((id) => id !== "")
      .map((id) => Number.parseInt(id, 10))
      .filter((id) => id);

    return array.includes(topic.category_id);
  }

  isFeatureActive(feature, isPrivateMessage) {
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
  }

  get avatarHtml() {
    const topic = this.args.outletArgs.topic;
    const featuredUsers = topic?.featuredUsers;

    if (!featuredUsers || !featuredUsers.length) {
      return "";
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
    return "";
  }

  <template>
    {{#if this.shouldShowExcerpt}}
      <a
        href={{@outletArgs.topic.url}}
        class="topic-excerpt highest-post-excerpt gjs"
      >
        {{#if
          (this.isFeatureActive
            "show_reply_icon" @outletArgs.topic.isPrivateMessage
          )
        }}
          {{dIcon "reply"}}
        {{/if}}
        {{#if
          (this.isFeatureActive
            "show_avatars" @outletArgs.topic.isPrivateMessage
          )
        }}
          {{this.avatarHtml}}
        {{/if}}
        {{dirSpan @outletArgs.topic.highest_post_excerpt htmlSafe=true}}
      </a>
    {{/if}}
  </template>
}
