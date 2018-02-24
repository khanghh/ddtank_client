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
      
      public function DevilTurnLotteryView(param1:DevilTurnTreasureView)
      {
         super();
         _treasureView = param1;
         init();
      }
      
      public function get isRunning() : Boolean
      {
         return _lotteryControl.isTurn;
      }
      
      private function init() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         _lotteryControl = new DevilTurnControl();
         _indexList = new DictionaryData();
         _cellList = new Vector.<DevilTurnCell>();
         var _loc2_:Vector.<DevilTurnGoodsItem> = DevilTurnManager.instance.model.goodsItemList;
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _indexList.add(_loc2_[_loc3_].ID,_loc3_);
            _loc1_ = new DevilTurnCell(_loc3_,ItemManager.Instance.getTemplateById(_loc2_[_loc3_].TemplateID),false,getCellBg());
            if(_loc2_[_loc3_].Type == 2)
            {
               _loc1_.setCount(_loc2_[_loc3_].Value);
            }
            PositionUtils.setPos(_loc1_,"devilTurn.lotteryCellPos" + _loc3_);
            addChild(_loc1_);
            _cellList.push(_loc1_);
            _loc3_++;
         }
         initEvent();
      }
      
      private function initEvent() : void
      {
         _lotteryControl.addEventListener("complete",__onTurnComplete);
         SocketManager.Instance.addEventListener(PkgEvent.format(608,11),__onSacrifice);
      }
      
      private function __onSacrifice(param1:PkgEvent) : void
      {
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = param1.pkg.readByte();
         _result = [];
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc2_ = param1.pkg.readByte();
            _loc5_ = param1.pkg.readByte();
            _loc3_ = {
               "id":_loc2_,
               "type":_loc5_
            };
            _result.push(_loc3_);
            _loc6_++;
         }
         DevilTurnManager.instance.lotteryRunning = true;
         _lotteryControl.turn(_cellList,_indexList[_loc2_]);
      }
      
      private function __onTurnComplete(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = _result;
         for each(var _loc2_ in _result)
         {
            _cellList[_indexList[_loc2_.id]].selected = true;
         }
         var _loc3_:DevilTurnGoodsView = new DevilTurnGoodsView(_result,_treasureView.isContinue,closeCall);
         LayerManager.Instance.addToLayer(_loc3_,3,true,1);
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
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(0,0,48,48);
         _loc1_.graphics.endFill();
         return _loc1_;
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
