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
      
      public function initList(overList:Vector.<ActivityData>, noOverList:Vector.<ActivityData>) : void
      {
         var i:int = 0;
         var list:* = null;
         clearList();
         var arr:Array = [];
         arr.push(noOverList);
         arr.push(overList);
         for(i = 0; i < 2; )
         {
            list = new DayActivityLeftList(_resArray[i],arr[i],_boolArray[i]);
            list.y = (list.height + 4) * i + 36;
            list.setTxt(_wordArray[i]);
            list.x = 18;
            _list.addChild(list);
            _itemList.push(list);
            i++;
         }
         _panel.invalidateViewport();
      }
      
      private function clearList() : void
      {
         var i:int = 0;
         if(!_itemList)
         {
            return;
         }
         i = 0;
         while(i < 2)
         {
            if(_itemList.length > 0)
            {
               while(_itemList[i].numChildren)
               {
                  ObjectUtils.disposeObject(_itemList[i].getChildAt(0));
               }
               ObjectUtils.disposeObject(_itemList[i]);
            }
            i++;
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
