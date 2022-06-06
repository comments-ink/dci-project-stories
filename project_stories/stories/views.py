from django.urls import reverse
from django.views.generic import DateDetailView, ListView

from .models import Story, check_comments_input_allowed


class StoryListView(ListView):
    def get_queryset(self):
        return Story.objects.published()


class StoryDetailView(DateDetailView):
    model = Story
    date_field = "published_time"
    month_format = "%m"

    def get_context_data(self, **kwargs):
        context = super(StoryDetailView, self).get_context_data(**kwargs)
        obj = context.get("object")
        context.update(
            {
                "next": reverse("comments-ink-sent"),
                "is_comment_input_allowed": check_comments_input_allowed(obj),
            }
        )
        return context
