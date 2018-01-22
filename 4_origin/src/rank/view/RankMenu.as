package rank.view
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import rank.RankManager;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class RankMenu extends Sprite implements Disposeable
   {
       
      
      private var _selectItem:RankCell;
      
      private var _cellArr:Array;
      
      public function RankMenu()
      {
         _cellArr = [];
         super();
         createUI();
      }
      
      private function createUI() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = WonderfulActivityManager.Instance.rankDic;
         for(var _loc1_ in WonderfulActivityManager.Instance.rankDic)
         {
            _loc3_ = WonderfulActivityManager.Instance.rankDic[_loc1_] as GmActivityInfo;
            if(_loc3_)
            {
               _loc2_ = new RankCell(_loc3_);
               _loc2_.y = _loc4_ * 54;
               _loc2_.addEventListener("click",_cellClickedHandle);
               addChild(_loc2_);
               _cellArr.push(_loc2_);
               _loc4_++;
            }
         }
      }
      
      private function _cellClickedHandle(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:RankCell = param1.currentTarget as RankCell;
         setSelectItem(_loc2_);
         RankManager.instance.model.currentInfo = _loc2_.info;
         RankManager.instance.setCurrentInfo();
      }
      
      public function init() : void
      {
         _cellArr[0].dispatchEvent(new MouseEvent("click"));
      }
      
      private function setSelectItem(param1:RankCell) : void
      {
         if(param1 != _selectItem)
         {
            if(_selectItem)
            {
               _selectItem.selected = false;
            }
            _selectItem = param1;
            _selectItem.selected = true;
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(_selectItem)
         {
            _selectItem.dispose();
            _selectItem = null;
         }
         _loc2_ = 0;
         while(_loc2_ < _cellArr.length)
         {
            _loc1_ = _cellArr[_loc2_];
            if(_loc1_)
            {
               _loc1_.removeEventListener("click",_cellClickedHandle);
               _loc1_.dispose();
               _loc1_ = null;
            }
            _loc2_++;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
