package consortion.view.club
{
   import com.pickgliss.ui.controls.container.VBox;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaApplyInfo;
   import consortion.event.ConsortionEvent;
   import ddt.data.ConsortiaInfo;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class ConsortionList extends VBox
   {
       
      
      private var _currentItem:ConsortionListItem;
      
      private var items:Vector.<ConsortionListItem>;
      
      private var _selfApplyList:Vector.<ConsortiaApplyInfo>;
      
      public function ConsortionList()
      {
         super();
         _spacing = 3;
         __applyListChange(null);
         ConsortionModelManager.Instance.model.addEventListener("myApplyListIsChange",__applyListChange);
      }
      
      private function __applyListChange(param1:ConsortionEvent) : void
      {
         _selfApplyList = ConsortionModelManager.Instance.model.myApplyList;
      }
      
      override protected function init() : void
      {
         var _loc1_:int = 0;
         super.init();
         items = new Vector.<ConsortionListItem>(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            items[_loc1_] = new ConsortionListItem(_loc1_);
            items[_loc1_].buttonMode = true;
            addChild(items[_loc1_]);
            items[_loc1_].addEventListener("click",__clickHandler);
            items[_loc1_].addEventListener("mouseOver",__overHandler);
            items[_loc1_].addEventListener("mouseOut",__outHandler);
            _loc1_++;
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            if(items[_loc2_] == param1.currentTarget as ConsortionListItem)
            {
               items[_loc2_].selected = true;
               _currentItem = items[_loc2_];
            }
            else
            {
               items[_loc2_].selected = false;
            }
            _loc2_++;
         }
         dispatchEvent(new ConsortionEvent("ClubItemSelected"));
      }
      
      public function get currentItem() : ConsortionListItem
      {
         return _currentItem;
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         (param1.currentTarget as ConsortionListItem).light = true;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         (param1.currentTarget as ConsortionListItem).light = false;
      }
      
      public function setListData(param1:Vector.<ConsortiaInfo>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 != null)
         {
            _loc2_ = param1.length;
            _loc3_ = 0;
            while(_loc3_ < 6)
            {
               if(_loc3_ < _loc2_)
               {
                  items[_loc3_].info = param1[_loc3_];
                  items[_loc3_].visible = true;
                  items[_loc3_].isApply = false;
               }
               else
               {
                  items[_loc3_].visible = false;
               }
               _loc3_++;
            }
            setStatus();
            if(_currentItem)
            {
               _currentItem.selected = false;
            }
         }
      }
      
      private function setStatus() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_selfApplyList != null)
         {
            _loc3_ = 0;
            while(_loc3_ < 6)
            {
               _loc1_ = _selfApplyList.length;
               if(items[_loc3_].visible)
               {
                  _loc2_ = 0;
                  while(_loc2_ < _loc1_)
                  {
                     if(items[_loc3_].info.ConsortiaID == _selfApplyList[_loc2_].ConsortiaID)
                     {
                        items[_loc3_].isApply = true;
                     }
                     _loc2_++;
                  }
               }
               _loc3_++;
            }
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         ConsortionModelManager.Instance.model.removeEventListener("myApplyListIsChange",__applyListChange);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            items[_loc1_].dispose();
            items[_loc1_].removeEventListener("click",__clickHandler);
            items[_loc1_].removeEventListener("mouseOver",__overHandler);
            items[_loc1_].removeEventListener("mouseOut",__outHandler);
            items[_loc1_] = null;
            _loc1_++;
         }
         _currentItem = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
