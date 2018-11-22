class Task < ApplicationRecord
    include RailsSortable::Model
    set_sortable :sort, without_updating_timestamps: true
end
