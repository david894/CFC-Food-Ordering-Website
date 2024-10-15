using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CFCAssignment
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RegisterCarouselScript();
        }

        private void RegisterCarouselScript()
        {
            string script = @"
                var slideIndex = 0;
                showSlides(slideIndex);

                function moveSlides(n) {
                    slideIndex += n;
                    showSlides(slideIndex);
                }

                function showSlides(index) {
                    var slides = document.getElementsByClassName('carousel-slide');
                    if (index >= slides.length) {
                        slideIndex = 0;
                    }
                    if (index < 0) {
                        slideIndex = slides.length - 1;
                    }
                    for (var i = 0; i < slides.length; i++) {
                        slides[i].classList.remove('active-slide');
                    }
                    slides[slideIndex].classList.add('active-slide');
                }
            ";

            ClientScript.RegisterStartupScript(this.GetType(), "carouselScript", script, true);
        }
    }
}