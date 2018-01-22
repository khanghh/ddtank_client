package sanXiao.game
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import homeTemple.view.N_BitmapDataNumber;
   import sanXiao.model.Pos;
   import sanXiao.model.SXCellData;
   import sanXiao.model.SXModel;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class SXGame extends Sprite implements Disposeable
   {
       
      
      private var _model:SXModel;
      
      private var _itemList:Vector.<Vector.<SXCellItem>>;
      
      private var _hits:int;
      
      private var _wordsHitsEffect:MovieClip;
      
      private var _conWordsHitsEffect:MovieClip;
      
      private var _listOfWords:Vector.<Bitmap>;
      
      private var _bmpNum:N_BitmapDataNumber;
      
      private var _hitsTip:Bitmap;
      
      private var _timerCheckDie:TimerJuggler;
      
      private var resetedCount:int = 0;
      
      private var _curProp:int;
      
      private var _selectedA:SXCellItem;
      
      private var _selectedB:SXCellItem;
      
      public var step:int = 0;
      
      private var _movedNum:int;
      
      private var _tipsList:Array;
      
      private var _boomLength:int;
      
      private var tween:TweenLite;
      
      private var tweenMax:TweenMax;
      
      public function SXGame()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.buttonMode = true;
         this.useHandCursor = true;
         _model = SanXiaoGameMediator.getInstance().model;
         _itemList = new Vector.<Vector.<SXCellItem>>();
         var _loc4_:Number = _model.ROW_COUNT;
         var _loc1_:Number = _model.COLUMN_COUNT;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _itemList[_loc6_] = new Vector.<SXCellItem>();
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _itemList[_loc6_][_loc2_] = new SXCellItem();
               _loc2_++;
            }
            _loc6_++;
         }
         _tipsList = [];
         _wordsHitsEffect = ComponentFactory.Instance.creat("ast.sanxiao.wrodsMovie");
         _wordsHitsEffect.mouseChildren = false;
         _wordsHitsEffect.mouseEnabled = false;
         _wordsHitsEffect.addEventListener("tips_end",onTipsEnd);
         _wordsHitsEffect.x = 115;
         _wordsHitsEffect.y = 180;
         _wordsHitsEffect.gotoAndStop(_wordsHitsEffect.totalFrames);
         addChild(_wordsHitsEffect);
         _conWordsHitsEffect = _wordsHitsEffect.getChildByName("con") as MovieClip;
         _listOfWords = new Vector.<Bitmap>();
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _listOfWords[_loc3_] = ComponentFactory.Instance.creatBitmap("ast.sanxiao.word" + _loc3_.toString());
            _loc3_++;
         }
         _listOfWords[_loc3_] = ComponentFactory.Instance.creatBitmap("ast.sanxiao.dieMap");
         _listOfWords[_loc3_].x = -100;
         _bmpNum = new N_BitmapDataNumber();
         _bmpNum.rect = new Rectangle(0,0,160,43);
         _bmpNum.gap = -1;
         var _loc5_:Vector.<BitmapData> = new Vector.<BitmapData>();
         _loc6_ = 0;
         while(_loc6_ < 10)
         {
            _loc5_.push(ComponentFactory.Instance.creatBitmapData("ast.sanxiao.n" + _loc6_.toString()));
            _loc6_++;
         }
         _bmpNum.numList = _loc5_;
         _bmpNum.dot = ComponentFactory.Instance.creatBitmapData("ast.sanxiao.hits");
         _hitsTip = new Bitmap(_bmpNum.getNumber("0"));
         _timerCheckDie = TimerManager.getInstance().addTimerJuggler(5000);
         _timerCheckDie.addEventListener("timer",onTimerCheckDieFunc);
         StageReferance.stage.addEventListener("click",onClick);
      }
      
      protected function onTimerCheckDieFunc(param1:Event) : void
      {
         var _loc2_:Boolean = _model.isDieMap();
         if(_loc2_)
         {
            _tipsList.unshift(_listOfWords[_listOfWords.length - 1]);
            playNextTips();
            SanXiaoGameMediator.getInstance().createNewMap();
         }
         _timerCheckDie.stop();
      }
      
      function resetGame() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         tweenMax && tweenMax.kill();
         var _loc2_:Vector.<Vector.<SXCellData>> = _model.map();
         var _loc4_:Number = _model.ROW_COUNT;
         var _loc1_:Number = _model.COLUMN_COUNT;
         resetedCount = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _itemList[_loc5_][_loc3_].mouseEnabled = false;
               _itemList[_loc5_][_loc3_].killBoom();
               _itemList[_loc5_][_loc3_].type = _loc2_[_loc5_][_loc3_].type;
               _itemList[_loc5_][_loc3_].curPos = new Pos(_loc5_ - _loc4_,_loc3_);
               _itemList[_loc5_][_loc3_].moveTo(new Pos(_loc5_,_loc3_),"tween",onResetComplete);
               addChildAt(_itemList[_loc5_][_loc3_],0);
               _loc3_++;
            }
            _loc5_++;
         }
         _timerCheckDie.reset();
         _timerCheckDie.start();
      }
      
      private function onResetComplete() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         resetedCount = resetedCount + 1;
         if(resetedCount == _model.ROW_COUNT * _model.COLUMN_COUNT)
         {
            _loc2_ = 0;
            while(_loc2_ < _model.ROW_COUNT)
            {
               _loc1_ = 0;
               while(_loc1_ < _model.COLUMN_COUNT)
               {
                  _itemList[_loc2_][_loc1_].mouseEnabled = true;
                  _loc1_++;
               }
               _loc2_++;
            }
         }
         SanXiaoGameMediator.getInstance().stopAnimation();
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:Boolean = false;
         if(param1.target is SXCellItem)
         {
            if(SanXiaoGameMediator.getInstance().stepRemain <= 0)
            {
               return;
            }
            _loc3_ = param1.target as SXCellItem;
            switch(int(step))
            {
               case 0:
                  _curProp = _model.curProp;
                  if(!int(_curProp))
                  {
                     _selectedA = _loc3_;
                     _selectedA.selected = true;
                     step = 1;
                  }
                  else
                  {
                     step = 2;
                     SanXiaoGameMediator.getInstance().checkProp(_loc3_.curPos);
                  }
                  break;
               case 1:
                  step = 2;
                  _selectedB = _loc3_;
                  _selectedB.selected = true;
                  _loc2_ = _model.cellTypeExchange(_selectedA.curPos,_selectedA.type,_selectedB.curPos,_selectedB.type);
                  if(_loc2_)
                  {
                     SanXiaoGameMediator.getInstance().startAnimation();
                     _movedNum = 0;
                     _selectedA.moveTo(_selectedB.curPos,"tween",afterExchange);
                     _selectedB.moveTo(_selectedA.curPos,"tween",afterExchange);
                  }
                  else
                  {
                     resetStep();
                  }
               default:
                  step = 2;
                  _selectedB = _loc3_;
                  _selectedB.selected = true;
                  _loc2_ = _model.cellTypeExchange(_selectedA.curPos,_selectedA.type,_selectedB.curPos,_selectedB.type);
                  if(_loc2_)
                  {
                     SanXiaoGameMediator.getInstance().startAnimation();
                     _movedNum = 0;
                     _selectedA.moveTo(_selectedB.curPos,"tween",afterExchange);
                     _selectedB.moveTo(_selectedA.curPos,"tween",afterExchange);
                  }
                  else
                  {
                     resetStep();
                  }
            }
         }
         else
         {
            resetStep();
         }
      }
      
      function checkProp(param1:Pos) : void
      {
         switch(int(_curProp) - 1)
         {
            case 0:
               SanXiaoGameMediator.getInstance().startAnimation();
               usePropCrossBomb(param1);
               break;
            case 1:
               SanXiaoGameMediator.getInstance().startAnimation();
               usePropSquareBomb(param1);
               break;
            case 2:
               SanXiaoGameMediator.getInstance().startAnimation();
               usePropClearColor(param1);
               break;
            case 3:
               SanXiaoGameMediator.getInstance().startAnimation();
               usePropChangeColor(param1);
         }
      }
      
      private function afterExchange() : void
      {
         _movedNum = _movedNum + 1;
         if(_movedNum < 2)
         {
            return;
         }
         _hits = 0;
         checkBoom();
      }
      
      private function checkBoom() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Vector.<SXCellData> = _model.canBoomCellsList([_selectedA,_selectedB]);
         if(_loc1_.length > 0)
         {
            SanXiaoGameMediator.getInstance().sendBoomList(_selectedA,_selectedB,_loc1_);
            _loc2_ = _selectedA.curPos.row;
            _loc4_ = _selectedA.curPos.column;
            _loc6_ = _selectedB.curPos.row;
            _loc5_ = _selectedB.curPos.column;
            _loc3_ = _itemList[_loc2_][_loc4_];
            _itemList[_loc2_][_loc4_] = _itemList[_loc6_][_loc5_];
            _itemList[_loc6_][_loc5_] = _loc3_;
            boomHitsTips();
            boom(_loc1_);
         }
         else
         {
            _model.cellTypeExchange(_selectedA.curPos,_selectedA.type,_selectedB.curPos,_selectedB.type);
            _hits = 0;
            _selectedA.moveTo(_selectedB.curPos,"tween",resetStep);
            _selectedB.moveTo(_selectedA.curPos,"tween",resetStep);
            SanXiaoGameMediator.getInstance().stopAnimation();
         }
      }
      
      private function playNextTips() : void
      {
         var _loc1_:* = null;
         if(_tipsList.length > 0 && _wordsHitsEffect.currentFrame == _wordsHitsEffect.totalFrames)
         {
            _loc1_ = _tipsList.pop() as Bitmap;
            if(_conWordsHitsEffect.numChildren > 0)
            {
               _conWordsHitsEffect.removeChildAt(0);
            }
            _conWordsHitsEffect.addChild(_loc1_);
            _wordsHitsEffect.gotoAndPlay(1);
         }
      }
      
      protected function onTipsEnd(param1:Event) : void
      {
         playNextTips();
      }
      
      private function boomHitsTips() : void
      {
         if(_hits > 1)
         {
            _hitsTip.bitmapData = _bmpNum.getNumber((_hits - 1).toString() + ".");
            _tipsList.unshift(_hitsTip);
            playNextTips();
         }
      }
      
      private function boomPraiseWordsTip() : void
      {
         switch(int(_hits) - 1)
         {
            case 0:
            case 1:
               break;
            case 2:
            case 3:
               _tipsList.unshift(_listOfWords[2]);
               break;
            case 4:
            case 5:
            case 6:
               _tipsList.unshift(_listOfWords[3]);
               break;
            case 7:
            case 8:
            case 9:
               _tipsList.unshift(_listOfWords[4]);
         }
         playNextTips();
      }
      
      private function resetStep() : void
      {
         _selectedA && _loc1_;
         _selectedA = null;
         _selectedB && _loc1_;
         _selectedB = null;
         step = 0;
      }
      
      private function boom(param1:Vector.<SXCellData>) : void
      {
         $boomList = param1;
         onBoom = function():void
         {
            onFall = function():void
            {
               falled = falled + 1;
               if(falled == lenFall)
               {
                  tween = TweenLite.delayedCall(0.3,checkHits);
               }
            };
            checkHits = function():void
            {
               var _loc1_:Vector.<SXCellData> = _model.canBoomCellsList(movedList);
               if(_loc1_.length > 0)
               {
                  SanXiaoGameMediator.getInstance().sendBoomList(null,null,_loc1_);
                  boom(_loc1_);
               }
               else
               {
                  SanXiaoGameMediator.getInstance().stopAnimation();
                  boomPraiseWordsTip();
                  this.mask = null;
                  resetStep();
                  SanXiaoGameMediator.getInstance().sendHitsEnd();
               }
            };
            if(_model == null)
            {
               return;
            }
            var j:int = 0;
            while(j < _model.COLUMN_COUNT)
            {
               var emptyCellNum:int = 0;
               var i:int = _model.ROW_COUNT - 1;
               while(i >= 0)
               {
                  if(_itemList[i][j].type == 0)
                  {
                     emptyCellNum = emptyCellNum + 1;
                  }
                  else if(emptyCellNum > 0)
                  {
                     movedList.push(_itemList[i][j]);
                     _itemList[i][j].moveTo(new Pos(i + emptyCellNum,j));
                     _itemList[i + emptyCellNum][j] = _itemList[i][j];
                  }
                  i = Number(i) - 1;
               }
               j = Number(j) + 1;
            }
            var fillList:Vector.<SXCellData> = _model.boomAndFall($boomList);
            var rowDic:Dictionary = new Dictionary();
            var c:int = 0;
            while(c < _model.COLUMN_COUNT)
            {
               rowDic[c] = 0;
               c = Number(c) + 1;
            }
            var falled:int = 0;
            var lenFall:int = fillList.length;
            var k:int = 0;
            while(k < lenFall)
            {
               var _loc2_:* = fillList[k].column;
               var _loc3_:* = rowDic[_loc2_] - 1;
               rowDic[_loc2_] = _loc3_;
               boomedList[k].moveTo(new Pos(rowDic[fillList[k].column],fillList[k].column),"immediately");
               boomedList[k].killBoom();
               boomedList[k].type = fillList[k].type;
               boomedList[k].moveTo(new Pos(fillList[k].row,fillList[k].column),"tween",onFall);
               _itemList[fillList[k].row][fillList[k].column] = boomedList[k];
               movedList.push(boomedList[k]);
               k = Number(k) + 1;
            }
            SanXiaoGameMediator.getInstance().sendFillList(_model.mapDataArray());
            rowDic = null;
         };
         _timerCheckDie.reset();
         _timerCheckDie.start();
         _hits = _hits + 1;
         boomHitsTips();
         var boomedList:Vector.<SXCellItem> = new Vector.<SXCellItem>();
         var movedList:Array = [];
         _boomLength = $boomList.length;
         var _loc4_:int = 0;
         var _loc3_:* = $boomList;
         for each(v in $boomList)
         {
            boomedList.push(_itemList[v.row][v.column]);
            _itemList[v.row][v.column].boom();
         }
         tweenMax = TweenMax.delayedCall(1,onBoom);
      }
      
      private function usePropCrossBomb(param1:Pos) : void
      {
         var _loc2_:Vector.<SXCellData> = _model.cellPropCrossBomb(param1);
         SanXiaoGameMediator.getInstance().sendUseCrossBomb();
         SanXiaoGameMediator.getInstance().sendBoomList(null,null,_loc2_);
         _hits = 0;
         boom(_loc2_);
      }
      
      private function usePropSquareBomb(param1:Pos) : void
      {
         var _loc2_:Vector.<SXCellData> = _model.cellPropSquareBomb(param1);
         SanXiaoGameMediator.getInstance().sendUseSquareBomb();
         SanXiaoGameMediator.getInstance().sendBoomList(null,null,_loc2_);
         _hits = 0;
         boom(_loc2_);
      }
      
      private function usePropClearColor(param1:Pos) : void
      {
         var _loc2_:Vector.<SXCellData> = _model.cellPropClearColor(param1);
         SanXiaoGameMediator.getInstance().sendUseClearColor();
         SanXiaoGameMediator.getInstance().sendBoomList(null,null,_loc2_);
         _hits = 0;
         boom(_loc2_);
      }
      
      private function usePropChangeColor(param1:Pos) : void
      {
         var _loc3_:int = _itemList[param1.row][param1.column].type;
         var _loc2_:Vector.<SXCellData> = _model.cellPropChangeColor(param1);
         SanXiaoGameMediator.getInstance().sendUseChangeColor(_loc3_,_loc2_[0].type);
         changeColor(_loc2_);
         TweenLite.delayedCall(0.5,checkBoomChangeColor,[_loc2_]);
      }
      
      private function changeColor(param1:Vector.<SXCellData>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            _itemList[_loc2_.row][_loc2_.column].type = _loc2_.type;
         }
      }
      
      private function checkBoomChangeColor(param1:Vector.<SXCellData>) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         _hits = 0;
         var _loc2_:Array = [];
         var _loc5_:int = param1.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = param1[_loc6_];
            _loc2_.push(_itemList[_loc4_.row][_loc4_.column]);
            _loc6_++;
         }
         var _loc3_:Vector.<SXCellData> = _model.canBoomCellsList(_loc2_);
         if(_loc3_.length > 0)
         {
            SanXiaoGameMediator.getInstance().sendBoomList(null,null,_loc3_);
            boom(_loc3_);
         }
         else
         {
            SanXiaoGameMediator.getInstance().stopAnimation();
         }
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         StageReferance.stage.removeEventListener("click",onClick);
         TweenLite.killDelayedCallsTo(tween);
         TweenMax.killDelayedCallsTo(tweenMax);
         if(_itemList != null)
         {
            _loc3_ = _model.ROW_COUNT;
            _loc1_ = _model.COLUMN_COUNT;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  TweenMax.killTweensOf(_itemList[_loc4_][_loc2_]);
                  ObjectUtils.disposeObject(_itemList[_loc4_][_loc2_]);
                  _loc2_++;
               }
               _itemList[_loc4_].length = 0;
               _loc4_++;
            }
            _itemList.length = 0;
            _itemList = null;
         }
         _timerCheckDie.stop();
         TimerManager.getInstance().removeJugglerByTimer(_timerCheckDie);
         _timerCheckDie = null;
         _model = null;
         this.mask = null;
         if(_conWordsHitsEffect)
         {
            _conWordsHitsEffect.stop();
            ObjectUtils.disposeObject(_conWordsHitsEffect);
            _conWordsHitsEffect = null;
         }
         if(_wordsHitsEffect)
         {
            _wordsHitsEffect.stop();
            _wordsHitsEffect.removeEventListener("tips_end",onTipsEnd);
            ObjectUtils.disposeObject(_wordsHitsEffect);
            _wordsHitsEffect = null;
         }
         _tipsList.length = 0;
         _tipsList = null;
         _hitsTip = null;
         _bmpNum = null;
      }
   }
}
