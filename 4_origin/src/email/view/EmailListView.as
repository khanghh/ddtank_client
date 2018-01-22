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
      
      public function update(param1:Array, param2:Boolean = false) : void
      {
         var _loc4_:* = 0;
         var _loc3_:* = null;
         clearElements();
         _loc4_ = uint(0);
         while(_loc4_ < param1.length)
         {
            if(param2)
            {
               _loc3_ = new EmailStripSended();
            }
            else
            {
               _loc3_ = new EmailStrip();
            }
            _loc3_.addEventListener("select",__select);
            _loc3_.info = param1[_loc4_] as EmailInfo;
            if(_loc3_.info.Title == LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionCellView.Object") && _loc3_.info.Type == 9)
            {
               if(_loc3_.info.Annex1)
               {
                  _loc3_.info.Annex1.ValidDate = -1;
               }
            }
            addChild(_loc3_);
            _strips.push(_loc3_);
            _loc4_++;
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
         var _loc1_:* = 0;
         _loc1_ = uint(0);
         while(_loc1_ < _strips.length)
         {
            if(EmailStrip(_strips[_loc1_]).info.Type != 58)
            {
               if(!EmailStrip(_strips[_loc1_]).selected)
               {
                  return false;
               }
            }
            _loc1_++;
         }
         return true;
      }
      
      private function changeAll(param1:Boolean) : void
      {
         var _loc2_:* = 0;
         _loc2_ = uint(0);
         while(_loc2_ < _strips.length)
         {
            EmailStrip(_strips[_loc2_]).selected = param1;
            _loc2_++;
         }
      }
      
      private function isHaveConsortionMail() : Boolean
      {
         var _loc2_:Boolean = true;
         var _loc1_:Boolean = false;
         var _loc5_:int = 0;
         var _loc4_:* = _strips;
         for each(var _loc3_ in _strips)
         {
            if(_loc3_.info.Type == 59)
            {
               _loc1_ = true;
            }
            else if(!_loc3_.selected && _loc3_.info.Type != 59)
            {
               _loc2_ = false;
               break;
            }
         }
         return _loc2_ && _loc1_;
      }
      
      public function getSelectedMails() : Array
      {
         var _loc2_:* = 0;
         var _loc1_:Array = [];
         _loc2_ = uint(0);
         while(_loc2_ < _strips.length)
         {
            if(EmailStrip(_strips[_loc2_]).selected)
            {
               _loc1_.push(EmailStrip(_strips[_loc2_]).info);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function updateInfo(param1:EmailInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _strips;
         for each(var _loc2_ in _strips)
         {
            if(param1 == _loc2_.info)
            {
               _loc2_.info = param1;
               break;
            }
         }
      }
      
      private function clearElements() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _strips.length)
         {
            _strips[_loc1_].removeEventListener("select",__select);
            _strips[_loc1_].dispose();
            _strips[_loc1_] = null;
            _loc1_++;
         }
         _strips = [];
      }
      
      private function __select(param1:Event) : void
      {
         var _loc2_:EmailStrip = param1.target as EmailStrip;
         var _loc5_:int = 0;
         var _loc4_:* = _strips;
         for each(var _loc3_ in _strips)
         {
            if(_loc3_ != _loc2_)
            {
               _loc3_.isReading = false;
            }
         }
      }
      
      function canChangePage() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _strips;
         for each(var _loc1_ in _strips)
         {
            if(_loc1_.emptyItem)
            {
               return false;
            }
         }
         return true;
      }
   }
}
