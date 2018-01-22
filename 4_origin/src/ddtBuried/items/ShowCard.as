package ddtBuried.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddtBuried.BuriedControl;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class ShowCard extends Sprite
   {
       
      
      private var _mc:MovieClip;
      
      private var _list:Vector.<BagCell>;
      
      public function ShowCard()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _list = new Vector.<BagCell>();
         _mc = ComponentFactory.Instance.creat("buried.card.show");
         addChild(_mc);
         _mc.addFrameScript(69,cradOver);
         _mc.addFrameScript(10,intCardShow);
      }
      
      private function intCardShow() : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc1_:* = null;
         var _loc3_:int = BuriedManager.Instance.cardInitList.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = {};
            _loc2_.tempID = BuriedManager.Instance.cardInitList[_loc5_].tempID;
            _loc2_.count = BuriedManager.Instance.cardInitList[_loc5_].count;
            _loc4_ = ItemManager.Instance.getTemplateById(_loc2_.tempID);
            _loc1_ = new BagCell(0,_loc4_);
            _loc1_.x = 39;
            _loc1_.y = 107;
            _loc1_.setBgVisible(false);
            _loc1_.setCount(_loc2_.count);
            _mc["card" + (_loc5_ + 1)].addChild(_loc1_);
            _list.push(_loc1_);
            _mc["card" + (_loc5_ + 1)].goodsName.text = _loc4_.Name;
            _loc5_++;
         }
      }
      
      private function clearCell() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _list.length)
         {
            _list[_loc1_].dispose();
            ObjectUtils.disposeObject(_list[_loc1_]);
            _list[_loc1_] = null;
            while(_mc["card" + (_loc1_ + 1)].numChildren)
            {
               ObjectUtils.disposeObject(_mc["card" + (_loc1_ + 1)].getChildAt(0));
            }
            _loc1_++;
         }
      }
      
      public function play() : void
      {
         _mc.play();
      }
      
      public function resetFrame() : void
      {
         _mc.gotoAndStop(1);
      }
      
      private function cradOver() : void
      {
         _mc.stop();
         BuriedControl.Instance.dispatchEvent(new BuriedEvent("card_show_over"));
      }
      
      public function dispose() : void
      {
         if(_list)
         {
            clearCell();
         }
         if(_mc)
         {
            _mc.stop();
            while(_mc.numChildren)
            {
               ObjectUtils.disposeObject(_mc.getChildAt(0));
            }
         }
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         _mc = null;
         _list = null;
      }
   }
}
