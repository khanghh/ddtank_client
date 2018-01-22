package AvatarCollection.view
{
   import AvatarCollection.AvatarCollectionManager;
   import AvatarCollection.data.AvatarCollectionUnitVo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class AvatarCollectionAllPropertyView extends Sprite implements Disposeable
   {
       
      
      private var _allPropertyCellList:Vector.<AvatarCollectionPropertyCell>;
      
      public function AvatarCollectionAllPropertyView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _allPropertyCellList = new Vector.<AvatarCollectionPropertyCell>();
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = new AvatarCollectionPropertyCell(_loc2_);
            _loc1_.x = int(_loc2_ / 4) * 110;
            _loc1_.y = _loc2_ % 4 * 25;
            addChild(_loc1_);
            _allPropertyCellList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.addEventListener("updatePlayerState",__updatePlayerPropertyHandler);
      }
      
      private function __updatePlayerPropertyHandler(param1:Event) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc6_:int = 0;
         var _loc1_:* = null;
         var _loc11_:* = null;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc3_:Number = NaN;
         var _loc12_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:Array = AvatarCollectionManager.instance.maleUnitList;
         _loc8_ = _loc8_.concat(AvatarCollectionManager.instance.femaleUnitList);
         _loc8_ = _loc8_.concat(AvatarCollectionManager.instance.weaponUnitList);
         var _loc13_:AvatarCollectionUnitVo = new AvatarCollectionUnitVo();
         var _loc10_:Array = [_loc13_.Attack,_loc13_.Defence,_loc13_.Agility,_loc13_.Luck,_loc13_.Damage,_loc13_.Guard,_loc13_.Blood];
         _loc6_ = 0;
         while(_loc6_ < _loc8_.length)
         {
            _loc1_ = _loc8_[_loc6_];
            _loc11_ = [_loc1_.Attack,_loc1_.Defence,_loc1_.Agility,_loc1_.Luck,_loc1_.Damage,_loc1_.Guard,_loc1_.Blood];
            _loc9_ = _loc1_.totalItemList.length;
            _loc7_ = _loc1_.totalActivityItemCount;
            _loc2_ = _loc1_.endTime;
            _loc3_ = TimeManager.Instance.Now().getTime();
            if(_loc7_ < _loc9_ / 2)
            {
               _loc12_ = 0;
               while(_loc12_ < _loc10_.length)
               {
                  var _loc15_:* = _loc12_;
                  var _loc16_:* = _loc10_[_loc15_] + 0;
                  _loc10_[_loc15_] = _loc16_;
                  _loc12_++;
               }
            }
            else if(_loc7_ == _loc9_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc10_.length)
               {
                  _loc16_ = _loc4_;
                  _loc15_ = _loc10_[_loc16_] + _loc11_[_loc4_] * 2;
                  _loc10_[_loc16_] = _loc15_;
                  _loc4_++;
               }
            }
            else
            {
               _loc5_ = 0;
               while(_loc5_ < _loc10_.length)
               {
                  _loc15_ = _loc5_;
                  _loc16_ = _loc10_[_loc15_] + _loc11_[_loc5_];
                  _loc10_[_loc15_] = _loc16_;
                  _loc5_++;
               }
            }
            _loc6_++;
         }
         _loc13_.Attack = _loc10_[0];
         _loc13_.Defence = _loc10_[1];
         _loc13_.Agility = _loc10_[2];
         _loc13_.Luck = _loc10_[3];
         _loc13_.Damage = _loc10_[4];
         _loc13_.Guard = _loc10_[5];
         _loc13_.Blood = _loc10_[6];
         var _loc18_:int = 0;
         var _loc17_:* = _allPropertyCellList;
         for each(var _loc14_ in _allPropertyCellList)
         {
            _loc14_.refreshAllProperty(_loc13_);
         }
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.removeEventListener("updatePlayerState",__updatePlayerPropertyHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _allPropertyCellList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
