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
         var info:* = null;
         var cell:* = null;
         var i:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = WonderfulActivityManager.Instance.rankDic;
         for(var id in WonderfulActivityManager.Instance.rankDic)
         {
            info = WonderfulActivityManager.Instance.rankDic[id] as GmActivityInfo;
            if(info)
            {
               cell = new RankCell(info);
               cell.y = i * 54;
               cell.addEventListener("click",_cellClickedHandle);
               addChild(cell);
               _cellArr.push(cell);
               i++;
            }
         }
      }
      
      private function _cellClickedHandle(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var item:RankCell = event.currentTarget as RankCell;
         setSelectItem(item);
         RankManager.instance.model.currentInfo = item.info;
         RankManager.instance.setCurrentInfo();
      }
      
      public function init() : void
      {
         _cellArr[0].dispatchEvent(new MouseEvent("click"));
      }
      
      private function setSelectItem(item:RankCell) : void
      {
         if(item != _selectItem)
         {
            if(_selectItem)
            {
               _selectItem.selected = false;
            }
            _selectItem = item;
            _selectItem.selected = true;
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var cell:* = null;
         if(_selectItem)
         {
            _selectItem.dispose();
            _selectItem = null;
         }
         i = 0;
         while(i < _cellArr.length)
         {
            cell = _cellArr[i];
            if(cell)
            {
               cell.removeEventListener("click",_cellClickedHandle);
               cell.dispose();
               cell = null;
            }
            i++;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
