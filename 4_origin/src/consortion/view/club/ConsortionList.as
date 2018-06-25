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
      
      private function __applyListChange(event:ConsortionEvent) : void
      {
         _selfApplyList = ConsortionModelManager.Instance.model.myApplyList;
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         super.init();
         items = new Vector.<ConsortionListItem>(6);
         for(i = 0; i < 6; )
         {
            items[i] = new ConsortionListItem(i);
            items[i].buttonMode = true;
            addChild(items[i]);
            items[i].addEventListener("click",__clickHandler);
            items[i].addEventListener("mouseOver",__overHandler);
            items[i].addEventListener("mouseOut",__outHandler);
            i++;
         }
      }
      
      private function __clickHandler(event:MouseEvent) : void
      {
         var i:int = 0;
         SoundManager.instance.play("008");
         for(i = 0; i < 6; )
         {
            if(items[i] == event.currentTarget as ConsortionListItem)
            {
               items[i].selected = true;
               _currentItem = items[i];
            }
            else
            {
               items[i].selected = false;
            }
            i++;
         }
         dispatchEvent(new ConsortionEvent("ClubItemSelected"));
      }
      
      public function get currentItem() : ConsortionListItem
      {
         return _currentItem;
      }
      
      private function __overHandler(event:MouseEvent) : void
      {
         (event.currentTarget as ConsortionListItem).light = true;
      }
      
      private function __outHandler(event:MouseEvent) : void
      {
         (event.currentTarget as ConsortionListItem).light = false;
      }
      
      public function setListData(data:Vector.<ConsortiaInfo>) : void
      {
         var len:int = 0;
         var i:int = 0;
         if(data != null)
         {
            len = data.length;
            for(i = 0; i < 6; )
            {
               if(i < len)
               {
                  items[i].info = data[i];
                  items[i].visible = true;
                  items[i].isApply = false;
               }
               else
               {
                  items[i].visible = false;
               }
               i++;
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
         var i:int = 0;
         var len:int = 0;
         var j:int = 0;
         if(_selfApplyList != null)
         {
            for(i = 0; i < 6; )
            {
               len = _selfApplyList.length;
               if(items[i].visible)
               {
                  for(j = 0; j < len; )
                  {
                     if(items[i].info.ConsortiaID == _selfApplyList[j].ConsortiaID)
                     {
                        items[i].isApply = true;
                     }
                     j++;
                  }
               }
               i++;
            }
         }
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         ConsortionModelManager.Instance.model.removeEventListener("myApplyListIsChange",__applyListChange);
         for(i = 0; i < 6; )
         {
            items[i].dispose();
            items[i].removeEventListener("click",__clickHandler);
            items[i].removeEventListener("mouseOver",__overHandler);
            items[i].removeEventListener("mouseOut",__outHandler);
            items[i] = null;
            i++;
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
