document.addEventListener("turbo:load", function() {
    var closed = true;
    let cs = document.querySelector('div.category-chooser')
    if (cs == null) return;
    cs.addEventListener('click', function(){
        if (closed == true) {
            this.classList.add('opened');
            this.classList.remove('closed');
            closed = false;
        } else {
            this.classList.add('closed');
            this.classList.remove('opened');
            closed = true;
        }
    })

    document.querySelectorAll('div.category-chooser input, div.category-chooser label').forEach(element => element.addEventListener("click", function (e) {
      e.stopPropagation();
    }))

    document.querySelectorAll('input.category-check').forEach(element => element.addEventListener("click", function () {
        let category_id = function(category){
            category = category.replace(/[& ]/g, "");
            
            return category;
        }
        let current_categories = JSON.parse(document.querySelector("input#podcast_category").value);
        if (current_categories === null) current_categories = {};
        let category = this.value.split(",")[0];
        let sub_category = this.value.split(",")[1];
        let checked = this.checked;
        if (sub_category == '') {
            if (checked) {
                current_categories[category] = [];
            }else{
                document.querySelectorAll('input.chkSubCat-' + category_id(category)).forEach(element => element.checked = false);
                delete current_categories[category];
            }
        }else{
            if (checked) {
                document.querySelector('input#chkCategory-' + category_id(category)).checked = true;
                if (current_categories[category] == undefined) current_categories[category] = [];
                current_categories[category].push(sub_category);
            }else{
                current_categories[category].splice(current_categories[category].indexOf(sub_category),1);
               
            }
        }
        let category_json = JSON.stringify(current_categories);
        document.querySelector('input#podcast_category').value = category_json;
    }))
});