Vue.component('spinner', {
    template: '<span class="spinner-border spinner-border-sm"></span>'
});

Vue.component('page-header', function(resolve, reject) {
    var ax = axios.create({ baseURL: '/admin/' });
    ax.get('ui-common/page-header.html').then((response) => { resolve({

        props: {
            header_text: { type: String, required: true },
            loading_counter: { type: Number, required: true }
        },
        
        template: response.data
                        
    })}).catch((e) => {
        reject(e);
    });

});
