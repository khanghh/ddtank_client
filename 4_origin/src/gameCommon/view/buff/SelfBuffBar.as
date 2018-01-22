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
      
      public function SelfBuffBar(param1:DisplayObjectContainer, param2:DisplayObject)
      {
         _buffCells = new Vector.<BuffCell>();
         super();
         _gameArrow = param2;
         _container = param1;
      }
      
      public function dispose() : void
      {
         if(_living)
         {
            _living.removeEventListener("buffChanged",__updateCell);
         }
         var _loc1_:BuffCell = _buffCells.shift();
         while(_loc1_)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = _buffCells.shift();
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
      
      private function __updateCell(param1:LivingEvent) : void
      {
         var _loc6_:* = null;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         clearBuff();
         var _loc3_:int = _living == null?0:_living.localBuffs.length;
         var _loc4_:int = _living == null?0:_living.petBuffs.length;
         var _loc2_:int = _living == null?0:_living.barBuffs.length;
         var _loc5_:int = _loc3_ + _loc4_ + _loc2_;
         _trueWidth = 0;
         if(_loc5_ > 0 && _buffCells)
         {
            if(_loc3_ > 0)
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
            _loc9_ = 0;
            while(_loc9_ < _loc3_)
            {
               if(_loc9_ + 1 > _buffCells.length)
               {
                  _loc6_ = new BuffCell(null,null,false,true);
                  _buffCells.push(_loc6_);
               }
               else
               {
                  _loc6_ = _buffCells[_loc9_];
               }
               _loc6_.x = _loc9_ % 10 * 36 + 8;
               _loc6_.y = -Math.floor(_loc9_ / 10) * 36 + 6;
               addChild(_loc6_);
               _loc6_.setInfo(_living.localBuffs[_loc9_]);
               var _loc10_:int = 32;
               _loc6_.height = _loc10_;
               _loc6_.width = _loc10_;
               _loc9_++;
            }
            _loc7_ = _loc4_ + _loc2_;
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               if(_loc8_ + 1 + _loc3_ > _buffCells.length)
               {
                  _loc6_ = new BuffCell(null,null,false,true);
                  _buffCells.push(_loc6_);
               }
               else
               {
                  _loc6_ = _buffCells[_loc8_ + _loc3_];
               }
               if(_loc3_ > 0)
               {
                  _loc6_.x = (3 + _loc8_) % 10 * 36 + 15;
               }
               else
               {
                  _loc6_.x = _loc8_ % 10 * 36;
               }
               if(_loc8_ < _loc4_)
               {
                  _loc6_.setInfo(_living.petBuffs[_loc8_]);
               }
               else
               {
                  _loc6_.setInfo(_living.barBuffs[_loc8_ - _loc4_]);
               }
               _loc6_.y = -Math.floor((_loc8_ + _loc3_) / 10) * 36 + 6;
               addChild(_loc6_);
               _trueWidth = _loc6_.x + 32;
               _loc8_++;
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
         if(PropertyWaterBuffBar.getPropertyWaterBuffList(PlayerManager.Instance.Self.buffInfo).length > 0 && RoomManager.Instance.current.type != 18)
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
      
      public function drawBuff(param1:Living) : void
      {
         if(_living)
         {
            _living.removeEventListener("buffChanged",__updateCell);
         }
         _living = param1;
         if(_living)
         {
            _living.addEventListener("buffChanged",__updateCell);
         }
         __updateCell(null);
      }
      
      public function get right() : Number
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(_living)
         {
            _loc2_ = _living.localBuffs.length;
            _loc4_ = _living.petBuffs.length;
            _loc1_ = _living.barBuffs.length;
            _loc3_ = 0;
            if(_living.playerInfo && _living.playerInfo.buffInfo)
            {
               _loc3_ = PropertyWaterBuffBar.getPropertyWaterBuffList(_living.playerInfo.buffInfo).length;
            }
            _loc6_ = _loc2_ + _loc4_ + _loc1_ + _loc3_;
            _loc5_ = _loc6_ > 8?8:_loc6_;
         }
         return x + 40 + 44 * _loc5_;
      }
      
      public function set propertyWaterBuffBarVisible(param1:Boolean) : void
      {
         _propertyWaterBuffBarVisible = param1;
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
         for each(var _loc1_ in _buffCells)
         {
            _loc1_.clearSelf();
         }
         ObjectUtils.disposeObject(_back);
         _back = null;
      }
   }
}
