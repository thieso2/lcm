module Bettertabs2Helper
  def bettertabs_bootstrap(bettertabs_id, options={})    
    bettertabs bettertabs_id, options.merge(
            list_html_options: { class: "nav nav-tabs" },
            list_item_html_options: { class: ""} ) do |tab|
      yield tab
    end
  end
end