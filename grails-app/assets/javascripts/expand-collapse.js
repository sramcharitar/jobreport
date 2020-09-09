jQuery(document).ready(function($) {

    function enableDisableButtons(section) {
        var $section = $(section);
        
        // enable/disable "Collapse All" button
        if ($('a.toggleiconlink > img[src$="icon-collapse.gif"]', $section).length) {
            var $button = $('.button.collapse-all', $section);
            $button.removeClass('button-tertiary-disabled').addClass('button-tertiary').find('span').wrapInner('<a href="#"></a>');
        } else {
            var $button = $('.button.collapse-all', $section);
            $button.removeClass('button-tertiary').addClass('button-tertiary-disabled').find('span a').contents().unwrap();
        }
        
        // enable/disable "Expand All" button
        if ($('a.toggleiconlink > img[src$="icon-expand.gif"]', $section).length) {
            var $button = $('.button.expand-all', $section);
            $button.removeClass('button-tertiary-disabled').addClass('button-tertiary').find('span').wrapInner('<a href="#"></a>');
        } else {
            var $button = $('.button.expand-all', $section);
            $button.removeClass('button-tertiary').addClass('button-tertiary-disabled').find('span a').contents().unwrap();
        }
    }
    
    $('.section').each(function() {
        enableDisableButtons(this);
    });
    
    $('.button.expand-all a').live('click', function() {
        var $section = $(this).parents('.section').first();
        $('a.toggleiconlink > img[src$="icon-expand.gif"]', $section).parent().trigger('click');
        enableDisableButtons($section);
        return false;
    });
    
    $('.button.collapse-all a').live('click', function() {
        var $section = $(this).parents('.section').first();

        // avoid using pre-existing onclick handler which focuses the triggering link/icon upon collapse
        //$('a.toggleiconlink > img[src$="icon-collapse.gif"]', $section).parent().trigger('click!');

        $('a.toggleiconlink > img[src$="icon-collapse.gif"]', $section).each(function() {
            var $img = $(this);
            var num = $img.parent()[0].id.replace(/icon_q(\d+)$/, '$1');
            $('.content_q'+num).hide();
            $img[0].src = $img[0].src.replace(/collapse/, 'expand');
            $img[0].alt = $img[0].alt.replace(/Collapse/, 'Expand');
        });
        enableDisableButtons($section);
        return false;
    });
    
    $('a.toggleiconlink').click(function() {
        var $section = $(this).parents('.section').first();
        enableDisableButtons($section);
    });
    
});
