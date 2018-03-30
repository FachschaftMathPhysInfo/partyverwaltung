class Mailer < ActionMailer::Base

    default :from => request.env["PRODUCTION_EMAIL_ADDRESS"] || "akfest@mathphys.stura.uni-heidelberg.de"

    def insert_mail(user,shift)
        @user=user
        @shift=shift
        @bereich=Section.find(@shift.section_id)
        if validate_mail(user.mail)
            mail(:to => user.mail, :subject => "Deine Schicht am MathPhysTheo")
        end
    end 
    
    private
    def validate_mail(val)
        if val =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
            return true
        else
            return false
        end
    end   
end
