from django.urls import re_path

from .views import StoryDetailView, StoryListView

urlpatterns = [
    re_path(r"^$", StoryListView.as_view(), name="stories"),
    re_path(
        (
            r"^(?P<year>\d{4})/(?P<month>\d{1,2})/(?P<day>\d{1,2})/"
            r"(?P<slug>[-\w]+)/$"
        ),
        StoryDetailView.as_view(),
        name="story-detail",
    ),
]
