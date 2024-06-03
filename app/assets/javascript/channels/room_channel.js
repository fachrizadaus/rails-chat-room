$(function() {
    $('[data-channel-subscribe="room"]').each(function(index, element) {
        var $element = $(element),
            currentUsername = $element.data('current-user'),
            room_id = $element.data('room-id')
        messageTemplate = $('[data-role="message-template"]');

        $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000)

        App.cable.subscriptions.create(
            {
                channel: "RoomChannel",
                room: room_id
            },
            {
                received: function(data) {
                    var content = messageTemplate.children().clone(true, true);
                    content.find('[data-role="user-avatar"]').attr('src', data.user_avatar_url);
                    var chatPos = content.find('[data-role="chat-pos"]');

                    if (data.username === currentUsername) {
                        chatPos.addClass('flex-row-reverse sender');
                    } else {
                        chatPos.addClass('flex-row');
                    }
                    content.find('[data-role="user-name"]').text(data.username);
                    content.find('[data-role="message-text"]').text(data.message);
                    content.find('[data-role="message-date"]').text(formatDate(data.updated_at));
                    $element.append(content);
                    $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000);
                }
            }
        );
    });
});

function formatDate(dateString) {
    var options = {
        year: 'numeric',
        month: 'short',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        hour12: false
    };
    var date = new Date(dateString);
    return date.toLocaleDateString('en-GB', options).replace(',', '');
}