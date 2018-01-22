package dayActivity.view.dayActtivityView
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.ActivityData;
   import dayActivity.items.DayActivityLeftList;
   import flash.display.Sprite;
   
   public class DayActtivityLeftView extends Sprite implements Disposeable
   {
       
      
      private var _rightBack:MutipleImage;
      
      private var _resArray:Array;
      
      private var _wordArray:Array;
      
      private var _boolArray:Array;
      
      private var _panel:ScrollPanel;
      
      private var _list:VBox;
      
      private var _itemList:Vector.<DayActivityLeftList>;
      
      public function DayActtivityLeftView()
      {
         _resArray = ["day.activity.noover","day.activity.over"];
         _wordArray = ["ddt.dayActivity.activityNoOver","ddt.dayActivity.activityOver"];
         _boolArray = [true,false];
         super();
         initView();
      }
      
      private function initView() : void
      {
         _itemList = new Vector.<DayActivityLeftList>();
         _rightBack = ComponentFactory.Instance.creatComponentByStylename("dayActivityView.left.ActivityStateBg");
         addChild(_rightBack);
         _list = ComponentFactory.Instance.creatComponentByStylename("caddy.luckpaihangBox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("dayActivityView.left.scrollpanel");
         _panel.y = 21;
         _panel.setView(_list);
         addChild(_panel);
         _panel.invalidateViewport();
      }
      
      public function initList(param1:Vector.<ActivityData>, param2:Vector.<ActivityData>) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         clearList();
         var _loc3_:Array = [];
         _loc3_.push(param2);
         _loc3_.push(param1);
         _loc5_ = 0;
         while(_loc5_ < 2)
         {
            _loc4_ = new DayActivityLeftList(_resArray[_loc5_],_loc3_[_loc5_],_boolArray[_loc5_]);
            _loc4_.y = (_loc4_.height + 4) * _loc5_ + 36;
            _loc4_.setTxt(_wordArray[_loc5_]);
            _loc4_.x = 18;
            _list.addChild(_loc4_);
            _itemList.push(_loc4_);
            _loc5_++;
         }
         _panel.invalidateViewport();
      }
      
      private function clearList() : void
      {
         var _loc1_:int = 0;
         if(!_itemList)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            if(_itemList.length > 0)
            {
               while(_itemList[_loc1_].numChildren)
               {
                  ObjectUtils.disposeObject(_itemList[_loc1_].getChildAt(0));
               }
               ObjectUtils.disposeObject(_itemList[_loc1_]);
            }
            _loc1_++;
         }
         _itemList.splice(0,_itemList.length);
      }
      
      public function dispose() : void
      {
         clearList();
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         _itemList = null;
         _list = null;
         _panel = null;
      }
   }
}
