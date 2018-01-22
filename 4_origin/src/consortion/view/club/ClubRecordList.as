package consortion.view.club
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class ClubRecordList extends Sprite implements Disposeable
   {
      
      public static const INVITE:int = 1;
      
      public static const APPLY:int = 2;
       
      
      private var _items:Vector.<ClubRecordItem>;
      
      private var _panel:ScrollPanel;
      
      private var _vbox:VBox;
      
      private var _data;
      
      public function ClubRecordList()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _vbox = ComponentFactory.Instance.creatComponentByStylename("club.recordList.vbox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("club.recordList.panel");
         _panel.setView(_vbox);
         addChild(_panel);
      }
      
      public function setData(param1:Object, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         if(_data == param1)
         {
            return;
         }
         clearItem();
         _items = new Vector.<ClubRecordItem>();
         if(param1 && param1.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc3_ = new ClubRecordItem(param2);
               _loc3_.info = param1[_loc4_];
               _items.push(_loc3_);
               _vbox.addChild(_loc3_);
               _loc4_++;
            }
         }
         _panel.invalidateViewport();
      }
      
      private function clearItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_items && _items.length > 0)
         {
            _loc1_ = _items.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _items[_loc2_].dispose();
               _items[_loc2_] = null;
               _loc2_++;
            }
         }
         _items = null;
      }
      
      public function dispose() : void
      {
         clearItem();
         ObjectUtils.disposeAllChildren(this);
         _vbox = null;
         _panel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
