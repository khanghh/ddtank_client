package devilTurn.view
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import devilTurn.DevilTurnManager;
   import devilTurn.control.DevilTurnControl;
   import devilTurn.model.DevilTurnGoodsItem;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import road7th.data.DictionaryData;
   
   public class DevilTurnLotteryView extends Sprite implements Disposeable
   {
       
      
      private var _cellList:Vector.<DevilTurnCell>;
      
      private var _indexList:DictionaryData;
      
      private var _shine:Bitmap;
      
      private var _treasureView:DevilTurnTreasureView;
      
      private var _lotteryControl:DevilTurnControl;
      
      private var _result:Array;
      
      public function DevilTurnLotteryView(view:DevilTurnTreasureView)
      {
         super();
         _treasureView = view;
         init();
      }
      
      public function get isRunning() : Boolean
      {
         return _lotteryControl.isTurn;
      }
      
      private function init() : void
      {
         var i:int = 0;
         var cell:* = null;
         _lotteryControl = new DevilTurnControl();
         _indexList = new DictionaryData();
         _cellList = new Vector.<DevilTurnCell>();
         var list:Vector.<DevilTurnGoodsItem> = DevilTurnManager.instance.model.goodsItemList;
         for(i = 0; i < 8; )
         {
            _indexList.add(list[i].ID,i);
            cell = new DevilTurnCell(i,ItemManager.Instance.getTemplateById(list[i].TemplateID),false,getCellBg());
            if(list[i].Type == 2)
            {
               cell.setCount(list[i].Value);
            }
            PositionUtils.setPos(cell,"devilTurn.lotteryCellPos" + i);
            addChild(cell);
            _cellList.push(cell);
            i++;
         }
         initEvent();
      }
      
      private function initEvent() : void
      {
         _lotteryControl.addEventListener("complete",__onTurnComplete);
         SocketManager.Instance.addEventListener(PkgEvent.format(608,11),__onSacrifice);
      }
      
      private function __onSacrifice(e:PkgEvent) : void
      {
         var id:int = 0;
         var i:int = 0;
         var type:int = 0;
         var data:* = null;
         var len:int = e.pkg.readByte();
         _result = [];
         for(i = 0; i < len; )
         {
            id = e.pkg.readByte();
            type = e.pkg.readByte();
            data = {
               "id":id,
               "type":type
            };
            _result.push(data);
            i++;
         }
         DevilTurnManager.instance.lotteryRunning = true;
         _lotteryControl.turn(_cellList,_indexList[id]);
      }
      
      private function __onTurnComplete(e:Event) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = _result;
         for each(var data in _result)
         {
            _cellList[_indexList[data.id]].selected = true;
         }
         var view:DevilTurnGoodsView = new DevilTurnGoodsView(_result,_treasureView.isContinue,closeCall);
         LayerManager.Instance.addToLayer(view,3,true,1);
         DevilTurnManager.instance.lotteryRunning = false;
      }
      
      private function closeCall() : void
      {
         if(_treasureView)
         {
            _treasureView.continueLottery();
         }
      }
      
      private function removeEvent() : void
      {
         _lotteryControl.removeEventListener("complete",__onTurnComplete);
         SocketManager.Instance.removeEventListener(PkgEvent.format(608,11),__onSacrifice);
      }
      
      private function getCellBg() : Shape
      {
         var cellBg:Shape = new Shape();
         cellBg.graphics.beginFill(0,0);
         cellBg.graphics.drawRect(0,0,48,48);
         cellBg.graphics.endFill();
         return cellBg;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _lotteryControl.dispose();
         while(_cellList.length)
         {
            ObjectUtils.disposeObject(_cellList.pop());
         }
         _cellList = null;
         _indexList.clear();
         _indexList = null;
         if(_result)
         {
            _result.splice(0,_result.length);
         }
         _result = null;
         _treasureView = null;
      }
   }
}
