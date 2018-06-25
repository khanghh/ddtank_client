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
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         this.buttonMode = true;
         this.useHandCursor = true;
         _model = SanXiaoGameMediator.getInstance().model;
         _itemList = new Vector.<Vector.<SXCellItem>>();
         var _row:Number = _model.ROW_COUNT;
         var _column:Number = _model.COLUMN_COUNT;
         for(i = 0; i < _row; )
         {
            _itemList[i] = new Vector.<SXCellItem>();
            for(j = 0; j < _column; )
            {
               _itemList[i][j] = new SXCellItem();
               j++;
            }
            i++;
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
         for(k = 0; k < 6; )
         {
            _listOfWords[k] = ComponentFactory.Instance.creatBitmap("ast.sanxiao.word" + k.toString());
            k++;
         }
         _listOfWords[k] = ComponentFactory.Instance.creatBitmap("ast.sanxiao.dieMap");
         _listOfWords[k].x = -100;
         _bmpNum = new N_BitmapDataNumber();
         _bmpNum.rect = new Rectangle(0,0,170,43);
         _bmpNum.gap = -1;
         var numList:Vector.<BitmapData> = new Vector.<BitmapData>();
         for(i = 0; i < 10; )
         {
            numList.push(ComponentFactory.Instance.creatBitmapData("ast.sanxiao.n" + i.toString()));
            i++;
         }
         _bmpNum.numList = numList;
         _bmpNum.dot = ComponentFactory.Instance.creatBitmapData("ast.sanxiao.hits");
         _hitsTip = new Bitmap(_bmpNum.getNumber("0"));
         _timerCheckDie = TimerManager.getInstance().addTimerJuggler(5000);
         _timerCheckDie.addEventListener("timer",onTimerCheckDieFunc);
         StageReferance.stage.addEventListener("click",onClick);
      }
      
      protected function onTimerCheckDieFunc(e:Event) : void
      {
         var isDieMap:Boolean = _model.isDieMap();
         if(isDieMap)
         {
            _tipsList.unshift(_listOfWords[_listOfWords.length - 1]);
            playNextTips();
            SanXiaoGameMediator.getInstance().createNewMap();
         }
         _timerCheckDie.stop();
      }
      
      function resetGame() : void
      {
         var i:int = 0;
         var j:int = 0;
         tweenMax && tweenMax.kill();
         var map:Vector.<Vector.<SXCellData>> = _model.map();
         var _row:Number = _model.ROW_COUNT;
         var _column:Number = _model.COLUMN_COUNT;
         resetedCount = 0;
         for(i = 0; i < _row; )
         {
            for(j = 0; j < _column; )
            {
               _itemList[i][j].mouseEnabled = false;
               _itemList[i][j].killBoom();
               _itemList[i][j].type = map[i][j].type;
               _itemList[i][j].curPos = new Pos(i - _row,j);
               _itemList[i][j].moveTo(new Pos(i,j),"tween",onResetComplete);
               addChildAt(_itemList[i][j],0);
               j++;
            }
            i++;
         }
         _timerCheckDie.reset();
         _timerCheckDie.start();
      }
      
      private function onResetComplete() : void
      {
         var i:int = 0;
         var j:int = 0;
         resetedCount = resetedCount + 1;
         if(resetedCount == _model.ROW_COUNT * _model.COLUMN_COUNT)
         {
            for(i = 0; i < _model.ROW_COUNT; )
            {
               for(j = 0; j < _model.COLUMN_COUNT; )
               {
                  _itemList[i][j].mouseEnabled = true;
                  j++;
               }
               i++;
            }
         }
         SanXiaoGameMediator.getInstance().stopAnimation();
      }
      
      protected function onClick(e:MouseEvent) : void
      {
         var item:* = null;
         var suc:Boolean = false;
         if(e.target is SXCellItem)
         {
            if(SanXiaoGameMediator.getInstance().stepRemain <= 0)
            {
               return;
            }
            item = e.target as SXCellItem;
            switch(int(step))
            {
               case 0:
                  _curProp = _model.curProp;
                  if(!int(_curProp))
                  {
                     _selectedA = item;
                     _selectedA.selected = true;
                     step = 1;
                  }
                  else
                  {
                     step = 2;
                     SanXiaoGameMediator.getInstance().checkProp(item.curPos);
                  }
                  break;
               case 1:
                  step = 2;
                  _selectedB = item;
                  _selectedB.selected = true;
                  suc = _model.cellTypeExchange(_selectedA.curPos,_selectedA.type,_selectedB.curPos,_selectedB.type);
                  if(suc)
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
                  _selectedB = item;
                  _selectedB.selected = true;
                  suc = _model.cellTypeExchange(_selectedA.curPos,_selectedA.type,_selectedB.curPos,_selectedB.type);
                  if(suc)
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
      
      function checkProp($curPos:Pos) : void
      {
         switch(int(_curProp) - 1)
         {
            case 0:
               SanXiaoGameMediator.getInstance().startAnimation();
               usePropCrossBomb($curPos);
               break;
            case 1:
               SanXiaoGameMediator.getInstance().startAnimation();
               usePropSquareBomb($curPos);
               break;
            case 2:
               SanXiaoGameMediator.getInstance().startAnimation();
               usePropClearColor($curPos);
               break;
            case 3:
               SanXiaoGameMediator.getInstance().startAnimation();
               usePropChangeColor($curPos);
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
         var aR:int = 0;
         var aC:int = 0;
         var bR:int = 0;
         var bC:int = 0;
         var temp:* = null;
         var boomList:Vector.<SXCellData> = _model.canBoomCellsList([_selectedA,_selectedB]);
         if(boomList.length > 0)
         {
            SanXiaoGameMediator.getInstance().sendBoomList(_selectedA,_selectedB,boomList);
            aR = _selectedA.curPos.row;
            aC = _selectedA.curPos.column;
            bR = _selectedB.curPos.row;
            bC = _selectedB.curPos.column;
            temp = _itemList[aR][aC];
            _itemList[aR][aC] = _itemList[bR][bC];
            _itemList[bR][bC] = temp;
            boomHitsTips();
            boom(boomList);
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
         var tipBmp:* = null;
         if(_tipsList.length > 0 && _wordsHitsEffect.currentFrame == _wordsHitsEffect.totalFrames)
         {
            tipBmp = _tipsList.pop() as Bitmap;
            if(_conWordsHitsEffect.numChildren > 0)
            {
               _conWordsHitsEffect.removeChildAt(0);
            }
            _conWordsHitsEffect.addChild(tipBmp);
            _wordsHitsEffect.gotoAndPlay(1);
         }
      }
      
      protected function onTipsEnd(e:Event) : void
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
      
      private function boom($boomList:Vector.<SXCellData>) : void
      {
         $boomList = $boomList;
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
               var nextBoomList:Vector.<SXCellData> = _model.canBoomCellsList(movedList);
               if(nextBoomList.length > 0)
               {
                  SanXiaoGameMediator.getInstance().sendBoomList(null,null,nextBoomList);
                  boom(nextBoomList);
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
            for(var j:int = 0; j < _model.COLUMN_COUNT; )
            {
               var emptyCellNum:int = 0;
               for(var i:int = _model.ROW_COUNT - 1; i >= 0; )
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
            for(var c:int = 0; c < _model.COLUMN_COUNT; )
            {
               rowDic[c] = 0;
               c = Number(c) + 1;
            }
            var falled:int = 0;
            var lenFall:int = fillList.length;
            for(var k:int = 0; k < lenFall; )
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
      
      private function usePropCrossBomb(pos:Pos) : void
      {
         var boomList:Vector.<SXCellData> = _model.cellPropCrossBomb(pos);
         SanXiaoGameMediator.getInstance().sendUseCrossBomb();
         SanXiaoGameMediator.getInstance().sendBoomList(null,null,boomList);
         _hits = 0;
         boom(boomList);
      }
      
      private function usePropSquareBomb(pos:Pos) : void
      {
         var boomList:Vector.<SXCellData> = _model.cellPropSquareBomb(pos);
         SanXiaoGameMediator.getInstance().sendUseSquareBomb();
         SanXiaoGameMediator.getInstance().sendBoomList(null,null,boomList);
         _hits = 0;
         boom(boomList);
      }
      
      private function usePropClearColor(pos:Pos) : void
      {
         var boomList:Vector.<SXCellData> = _model.cellPropClearColor(pos);
         SanXiaoGameMediator.getInstance().sendUseClearColor();
         SanXiaoGameMediator.getInstance().sendBoomList(null,null,boomList);
         _hits = 0;
         boom(boomList);
      }
      
      private function usePropChangeColor(pos:Pos) : void
      {
         var originalType:int = _itemList[pos.row][pos.column].type;
         var boomList:Vector.<SXCellData> = _model.cellPropChangeColor(pos);
         SanXiaoGameMediator.getInstance().sendUseChangeColor(originalType,boomList[0].type);
         changeColor(boomList);
         TweenLite.delayedCall(0.5,checkBoomChangeColor,[boomList]);
      }
      
      private function changeColor(changeList:Vector.<SXCellData>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = changeList;
         for each(var v in changeList)
         {
            _itemList[v.row][v.column].type = v.type;
         }
      }
      
      private function checkBoomChangeColor(checkList:Vector.<SXCellData>) : void
      {
         var data:* = null;
         var i:int = 0;
         _hits = 0;
         var checkArr:Array = [];
         var len:int = checkList.length;
         for(i = 0; i < len; )
         {
            data = checkList[i];
            checkArr.push(_itemList[data.row][data.column]);
            i++;
         }
         var boomList:Vector.<SXCellData> = _model.canBoomCellsList(checkArr);
         if(boomList.length > 0)
         {
            SanXiaoGameMediator.getInstance().sendBoomList(null,null,boomList);
            boom(boomList);
         }
         else
         {
            SanXiaoGameMediator.getInstance().stopAnimation();
         }
      }
      
      public function dispose() : void
      {
         var _row:int = 0;
         var _column:int = 0;
         var i:int = 0;
         var j:int = 0;
         StageReferance.stage.removeEventListener("click",onClick);
         TweenLite.killDelayedCallsTo(tween);
         TweenMax.killDelayedCallsTo(tweenMax);
         if(_itemList != null)
         {
            _row = _model.ROW_COUNT;
            _column = _model.COLUMN_COUNT;
            for(i = 0; i < _row; )
            {
               for(j = 0; j < _column; )
               {
                  TweenMax.killTweensOf(_itemList[i][j]);
                  ObjectUtils.disposeObject(_itemList[i][j]);
                  j++;
               }
               _itemList[i].length = 0;
               i++;
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
