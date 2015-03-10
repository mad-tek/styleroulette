module ApplicationHelper

    def roulette
        #initialize Youtube_it
        client = YouTubeIt::OAuth2Client.new(dev_key: ENV['YT_DEV'])
        
        #calling query and generating random integer based on total number of results.
        response = client.videos_by(:query => (@style? "#{@style}" : "'dance'"), :user => 'stanceelements')
        randnum = rand(0..49)
        x = response.total_result_count-49
        #randnum cannot be over 450. Youtube will not return more than 500 queries
        maxnum = 450
        if x > maxnum
            x = maxnum
        end
        randoffset = rand(0..x)
        if @style.nil?
        else
            randoffset = rand(0..450)
        end
        
        #search query with random offset. to maximize search result, we have to use offset, because Youtube only returns a maximum of 50 results per query, but you have access to at least 500.
        response = client.videos_by(:query => (@style? "#{@style}" : "'dance', :user => 'stanceelements'"), :offset => randoffset, :max_results => 50,)
        logger.debug "randoffset is: #{randoffset}"
        
        #pick a random video from the search results and get its info
        video = response.videos[randnum]
        youtube_id = video.unique_id
        @youtube_id = youtube_id
        @title = video.title
        @author = video.author.name
        
        #check if there are ratings
        if video.rating.nil?
            @likes = 0
            @dislikes = 0
        else
            @likes = number_with_delimiter(video.rating.likes, :delimiter => ',')
            @dislikes = number_with_delimiter(video.rating.dislikes, :delimiter => ',')
        end
        @views = number_with_delimiter(video.view_count, :delimiter => ',')
        date_time = video.published_at
        @date = date_time.strftime("%b %d, %Y")
        
        #comment section
        @comment_count = video.comment_count
        comments = "https://gdata.youtube.com/feeds/api/videos/#{youtube_id}/comments?max-results=50&alt=json&prettyprint=true"
        all_comments = JSON.load(open(comments))
        feed = all_comments['feed']
        @entry = feed['entry']
        
        #uploader thumbnail
        uploader_id = video.author.uri
        uploader = JSON.load(open("#{uploader_id}?alt=json"))
        @uploader_thumb = uploader['entry']['media$thumbnail']['url']
        
        
    end
end
