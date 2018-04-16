class Mailer < ActionMailer::Base

    default :from => ENV["PRODUCTION_EMAIL_ADDRESS"] || "akfest@mathphys.stura.uni-heidelberg.de"

    def insert_mail(user,shift)
        @user=user
        @shift=shift
        @bereich=Section.find(@shift.section_id)
        if validate_mail(user.mail)
            mail(:to => user.mail, :subject => "Deine Schicht am MathPhysTheo")
        end
    end 
    
    def reminder_mail(user,shift)
        @user=user
        @shift=shift
        @bereich=Section.find(@shift.section_id)
        unless @bereich.text == nil
          @text = @bereich.text
        end
        if validate_mail(user.mail)
            mail(:to => user.mail, :subject => "REMINDER: Deine Schicht am MathPhysTheo")
        end
    end
    
    def custom_mail(user, subject, content)
        if validate_mail(user.mail)
            mail(:to => user.mail, :subject => subject, :body => content)
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
