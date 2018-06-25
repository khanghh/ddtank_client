package email.view
{
   import com.pickgliss.ui.controls.container.VBox;
   import ddt.data.email.EmailInfo;
   import ddt.manager.LanguageMgr;
   import flash.events.Event;
   
   public class EmailListView extends VBox
   {
       
      
      private var _strips:Array;
      
      public function EmailListView()
      {
         super();
         _strips = [];
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function update(emails:Array, isSendedMail:Boolean = false) : void
      {
         var i:* = 0;
         var strip:* = null;
         clearElements();
         for(i = uint(0); i < emails.length; )
         {
            if(isSendedMail)
            {
               strip = new EmailStripSended();
            }
            else
            {
               strip = new EmailStrip();
            }
            strip.addEventListener("select",__select);
            strip.info = emails[i] as EmailInfo;
            if(strip.info.Title == LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionCellView.Object") && strip.info.Type == 9)
            {
               if(strip.info.Annex1)
               {
                  strip.info.Annex1.ValidDate = -1;
               }
            }
            addChild(strip);
            _strips.push(strip);
            i++;
         }
         refreshChildPos();
      }
      
      public function switchSeleted() : void
      {
         if(allHasSelected() || isHaveConsortionMail())
         {
            changeAll(false);
            return;
         }
         changeAll(true);
      }
      
      private function allHasSelected() : Boolean
      {
         var i:* = 0;
         for(i = uint(0); i < _strips.length; )
         {
            if(EmailStrip(_strips[i]).info.Type != 58)
            {
               if(!EmailStrip(_strips[i]).selected)
               {
                  return false;
               }
            }
            i++;
         }
         return true;
      }
      
      private function changeAll(value:Boolean) : void
      {
         var i:* = 0;
         for(i = uint(0); i < _strips.length; )
         {
            EmailStrip(_strips[i]).selected = value;
            i++;
         }
      }
      
      private function isHaveConsortionMail() : Boolean
      {
         var vResult:Boolean = true;
         var sign:Boolean = false;
         var _loc5_:int = 0;
         var _loc4_:* = _strips;
         for each(var s in _strips)
         {
            if(s.info.Type == 59)
            {
               sign = true;
            }
            else if(!s.selected && s.info.Type != 59)
            {
               vResult = false;
               break;
            }
         }
         return vResult && sign;
      }
      
      public function getSelectedMails() : Array
      {
         var i:* = 0;
         var tempArr:Array = [];
         for(i = uint(0); i < _strips.length; )
         {
            if(EmailStrip(_strips[i]).selected)
            {
               tempArr.push(EmailStrip(_strips[i]).info);
            }
            i++;
         }
         return tempArr;
      }
      
      public function updateInfo(info:EmailInfo) : void
      {
         if(info == null)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _strips;
         for each(var strip in _strips)
         {
            if(info == strip.info)
            {
               strip.info = info;
               break;
            }
         }
      }
      
      private function clearElements() : void
      {
         var i:int = 0;
         for(i = 0; i < _strips.length; )
         {
            _strips[i].removeEventListener("select",__select);
            _strips[i].dispose();
            _strips[i] = null;
            i++;
         }
         _strips = [];
      }
      
      private function __select(event:Event) : void
      {
         var strip:EmailStrip = event.target as EmailStrip;
         var _loc5_:int = 0;
         var _loc4_:* = _strips;
         for each(var i in _strips)
         {
            if(i != strip)
            {
               i.isReading = false;
            }
         }
      }
      
      function canChangePage() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _strips;
         for each(var i in _strips)
         {
            if(i.emptyItem)
            {
               return false;
            }
         }
         return true;
      }
   }
}
