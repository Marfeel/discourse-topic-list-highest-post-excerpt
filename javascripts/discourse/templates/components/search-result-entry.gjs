import { fn, hash } from "@ember/helper";
import { on } from "@ember/modifier";
import RouteTemplate from "ember-route-template";
import { and } from "truth-helpers";
import HighlightSearch from "discourse/components/highlight-search";
import PluginOutlet from "discourse/components/plugin-outlet";
import TrackSelected from "discourse/components/track-selected";
import avatar from "discourse/helpers/avatar";
import categoryLink from "discourse/helpers/category-link";
import icon from "discourse/helpers/d-icon";
import discourseTags from "discourse/helpers/discourse-tags";
import formatDate from "discourse/helpers/format-date";
import htmlSafe from "discourse/helpers/html-safe";
import raw from "discourse/helpers/raw";

export default RouteTemplate(
  <template>
    <div class="author">
      <a
        href={{@controller.post.userPath}}
        data-user-card={{@controller.post.username}}
      >
        {{avatar @controller.post imageSize="large"}}
      </a>
    </div>

    <div class="fps-topic">
      <div class="topic">
        {{#if @controller.bulkSelectEnabled}}
          <TrackSelected
            @selectedList={{@controller.selected}}
            @selectedId={{@controller.post.topic}}
            class="bulk-select"
          />
        {{/if}}

        <a
          href={{@controller.post.url}}
          {{on "click" (fn @controller.logClick @controller.post.topic_id)}}
          class="search-link{{if @controller.post.topic.visited ' visited'}}"
          role="heading"
          aria-level="2"
        >
          {{raw
            "topic-status"
            topic=@controller.post.topic
            showPrivateMessageIcon=true
          }}
          <span class="topic-title">
            {{#if @controller.post.useTopicTitleHeadline}}
              {{htmlSafe @controller.post.topicTitleHeadline}}
            {{else}}
              <HighlightSearch @highlight={{@controller.highlightQuery}}>
                {{htmlSafe @controller.post.topic.fancyTitle}}
              </HighlightSearch>
            {{/if}}
          </span>
          <PluginOutlet
            @name="search-results-topic-title-suffix"
            @outletArgs={{hash topic=@controller.post.topic}}
          />
        </a>

        <div class="search-category">
          {{#if @controller.post.topic.category.parentCategory}}
            {{categoryLink @controller.post.topic.category.parentCategory}}
          {{/if}}
          {{categoryLink @controller.post.topic.category hideParent=true}}
          {{#if @controller.post.topic}}
            {{discourseTags @controller.post.topic}}
          {{/if}}
          <span>
            <PluginOutlet
              @name="full-page-search-category"
              @connectorTagName="div"
              @outletArgs={{hash post=@controller.post}}
            />
          </span>
        </div>
      </div>

      <div class="blurb container">
        <span class="date">
          {{formatDate @controller.post.created_at format="tiny"}}
          {{#if @controller.post.blurb}}
            <span class="separator">-</span>
          {{/if}}
        </span>
        {{#if
          (and
            @controller.post.topic.highest_post_excerpt
            @controller.post.topic.isPrivateMessage
          )
        }}
          {{#if @controller.siteSettings.use_pg_headlines_for_excerpt}}
            {{htmlSafe @controller.post.topic.highest_post_excerpt}}
          {{else}}
            <HighlightSearch @highlight={{@controller.highlightQuery}}>
              {{htmlSafe @controller.post.topic.highest_post_excerpt}}
            </HighlightSearch>
          {{/if}}
        {{else}}
          {{#if @controller.post.blurb}}
            {{#if @controller.siteSettings.use_pg_headlines_for_excerpt}}
              {{htmlSafe @controller.post.blurb}}
            {{else}}
              <HighlightSearch @highlight={{@controller.highlightQuery}}>
                {{htmlSafe @controller.post.blurb}}
              </HighlightSearch>
            {{/if}}
          {{/if}}
        {{/if}}
      </div>

      {{#if @controller.showLikeCount}}
        {{#if @controller.post.like_count}}
          <span class="like-count">
            <span class="value">{{@controller.post.like_count}}</span>
            {{icon "heart"}}
          </span>
        {{/if}}
      {{/if}}
    </div>

    <PluginOutlet @name="after-search-result-entry" />
  </template>
);
