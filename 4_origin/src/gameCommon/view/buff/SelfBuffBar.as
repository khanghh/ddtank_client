package gameCommon.view.buff
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import game.view.buff.BuffCell;
   import game.view.propertyWaterBuff.PropertyWaterBuffBar;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import room.RoomManager;
   
   public class SelfBuffBar extends Sprite implements Disposeable
   {
      
      public static var UPDATECELL:String = "updateCell";
       
      
      private var _buffCells:Vector.<BuffCell>;
      
      private var _back:Bitmap;
      
      private var _living:Living;
      
      private var _container:DisplayObjectContainer;
      
      private var _gameArrow:DisplayObject;
      
      private var _trueWidth:Number;
      
      private var _propertyWaterBuffBar:PropertyWaterBuffBar;
      
      private var _propertyWaterBuffBarVisible:Boolean;
      
      public function SelfBuffBar(container:DisplayObjectContainer, gameArrow:DisplayObject)
      {
         _buffCells = new Vector.<BuffCell>();
         super();
         _gameArrow = gameArrow;
         _container = container;
      }
      
      public function dispose() : void
      {
         if(_living)
         {
            _living.removeEventListener("buffChanged",__updateCell);
         }
         var cell:BuffCell = _buffCells.shift();
         while(cell)
         {
            ObjectUtils.disposeObject(cell);
            cell = _buffCells.shift();
         }
         _buffCells = null;
         ObjectUtils.disposeObject(_propertyWaterBuffBar);
         _propertyWaterBuffBar = null;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         _gameArrow = null;
         _container = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function __updateCell(event:LivingEvent) : void
      {
         var cell:* = null;
         var i:int = 0;
         var len:int = 0;
         var j:int = 0;
         clearBuff();
         var localBuffLen:int = _living == null?0:_living.localBuffs.length;
         var petBuffLen:int = _living == null?0:_living.petBuffs.length;
         var barBuffLen:int = _living == null?0:_living.barBuffs.length;
         var maxLen:int = localBuffLen + petBuffLen + barBuffLen;
         _trueWidth = 0;
         if(maxLen > 0 && _buffCells)
         {
            if(localBuffLen > 0)
            {
               if(!_back)
               {
                  _back = ComponentFactory.Instance.creatBitmap("asset.game.selfBuff.back");
                  addChild(_back);
               }
               _trueWidth = _back.width;
            }
            else if(_back)
            {
               if(_back)
               {
                  ObjectUtils.disposeObject(_back);
               }
               _back = null;
            }
            i = 0;
            while(i < localBuffLen)
            {
               if(i + 1 > _buffCells.length)
               {
                  cell = new BuffCell(null,null,false,true);
                  _buffCells.push(cell);
               }
               else
               {
                  cell = _buffCells[i];
               }
               cell.x = i % 10 * 36 + 8;
               cell.y = -Math.floor(i / 10) * 36 + 6;
               addChild(cell);
               cell.setInfo(_living.localBuffs[i]);
               var _loc10_:int = 32;
               cell.height = _loc10_;
               cell.width = _loc10_;
               i++;
            }
            len = petBuffLen + barBuffLen;
            for(j = 0; j < len; )
            {
               if(j + 1 + localBuffLen > _buffCells.length)
               {
                  cell = new BuffCell(null,null,false,true);
                  _buffCells.push(cell);
               }
               else
               {
                  cell = _buffCells[j + localBuffLen];
               }
               if(localBuffLen > 0)
               {
                  cell.x = (3 + j) % 10 * 36 + 15;
               }
               else
               {
                  cell.x = j % 10 * 36;
               }
               if(j < petBuffLen)
               {
                  cell.setInfo(_living.petBuffs[j]);
               }
               else
               {
                  cell.setInfo(_living.barBuffs[j - petBuffLen]);
               }
               cell.y = -Math.floor((j + localBuffLen) / 10) * 36 + 6;
               addChild(cell);
               _trueWidth = cell.x + 32;
               j++;
            }
            if(parent == null && !(GameControl.Instance.Current.missionInfo && GameControl.Instance.Current.missionInfo.isWorldCupI) && GameControl.Instance.isShowSelfBuffBar)
            {
               if(_container.contains(_gameArrow))
               {
                  _container.addChildAt(this,_container.getChildIndex(_gameArrow));
               }
               else
               {
                  _container.addChild(this);
               }
            }
         }
         else if(parent)
         {
            parent.removeChild(this);
         }
         createPropertyWaterBuffBar();
         dispatchEvent(new CEvent(UPDATECELL));
      }
      
      private function createPropertyWaterBuffBar() : void
      {
         if(PropertyWaterBuffBar.getPropertyWaterBuffList(PlayerManager.Instance.Self.buffInfo).length > 0 && RoomManager.Instance.current.type != 18 && RoomManager.Instance.current.type != 70)
         {
            if(!_propertyWaterBuffBar)
            {
               _propertyWaterBuffBar = new PropertyWaterBuffBar();
               PositionUtils.setPos(_propertyWaterBuffBar,"game.view.propertyWaterBuff.PropertyWaterBuffBarPos");
               _propertyWaterBuffBar.visible = _propertyWaterBuffBarVisible;
               addChild(_propertyWaterBuffBar);
            }
            _propertyWaterBuffBar.x = _trueWidth == 0?6:Number(_trueWidth + 6);
            if(parent == null && !(GameControl.Instance.Current.missionInfo && GameControl.Instance.Current.missionInfo.isWorldCupI) && GameControl.Instance.isShowSelfBuffBar)
            {
               if(_container.contains(_gameArrow))
               {
                  _container.addChildAt(this,_container.getChildIndex(_gameArrow));
               }
               else
               {
                  _container.addChild(this);
               }
            }
         }
      }
      
      public function drawBuff(living:Living) : void
      {
         if(_living)
         {
            _living.removeEventListener("buffChanged",__updateCell);
         }
         _living = living;
         if(_living)
         {
            _living.addEventListener("buffChanged",__updateCell);
         }
         __updateCell(null);
      }
      
      public function get right() : Number
      {
         var localBuffLen:int = 0;
         var petBuffLen:int = 0;
         var barBuffLen:int = 0;
         var propertyBuffLen:int = 0;
         var buffLen:int = 0;
         var len:int = 0;
         if(_living)
         {
            localBuffLen = _living.localBuffs.length;
            petBuffLen = _living.petBuffs.length;
            barBuffLen = _living.barBuffs.length;
            propertyBuffLen = 0;
            if(_living.playerInfo && _living.playerInfo.buffInfo)
            {
               propertyBuffLen = PropertyWaterBuffBar.getPropertyWaterBuffList(_living.playerInfo.buffInfo).length;
            }
            buffLen = localBuffLen + petBuffLen + barBuffLen + propertyBuffLen;
            len = buffLen > 8?8:buffLen;
         }
         return x + 40 + 44 * len;
      }
      
      public function set propertyWaterBuffBarVisible(value:Boolean) : void
      {
         _propertyWaterBuffBarVisible = value;
         if(_propertyWaterBuffBar)
         {
            _propertyWaterBuffBar.visible = _propertyWaterBuffBarVisible;
         }
      }
      
      public function get trueWidth() : Number
      {
         return _trueWidth;
      }
      
      private function clearBuff() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _buffCells;
         for each(var cell in _buffCells)
         {
            cell.clearSelf();
         }
         ObjectUtils.disposeObject(_back);
         _back = null;
      }
   }
}
