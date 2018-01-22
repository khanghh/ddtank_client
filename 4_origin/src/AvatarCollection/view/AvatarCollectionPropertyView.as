package AvatarCollection.view
{
   import AvatarCollection.data.AvatarCollectionUnitVo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class AvatarCollectionPropertyView extends Sprite implements Disposeable
   {
       
      
      private var _propertyCellList:Vector.<AvatarCollectionPropertyCell>;
      
      private var _allPropertyView:AvatarCollectionAllPropertyView;
      
      private var _tip:AvatarCollectionPropertyTip;
      
      private var _tipSprite:Sprite;
      
      private var _completeStatus:int = -1;
      
      public function AvatarCollectionPropertyView()
      {
         super();
         this.x = 22;
         this.y = 252;
         this.mouseEnabled = false;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _propertyCellList = new Vector.<AvatarCollectionPropertyCell>();
         _allPropertyView = new AvatarCollectionAllPropertyView();
         _allPropertyView.x = 274;
         _allPropertyView.y = 0;
         addChild(_allPropertyView);
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = new AvatarCollectionPropertyCell(_loc2_);
            _loc1_.x = int(_loc2_ / 4) * 110;
            _loc1_.y = _loc2_ % 4 * 25;
            addChild(_loc1_);
            _propertyCellList.push(_loc1_);
            _loc2_++;
         }
         _tip = new AvatarCollectionPropertyTip();
         _tip.visible = false;
         PositionUtils.setPos(_tip,"avatarColl.propertyView.tipPos");
         addChild(_tip);
         _tipSprite = new Sprite();
         _tipSprite.graphics.beginFill(16711680,0);
         _tipSprite.graphics.drawRect(-15,-20,242,122);
         _tipSprite.graphics.endFill();
         addChild(_tipSprite);
      }
      
      private function initEvent() : void
      {
         _tipSprite.addEventListener("mouseOver",overHandler,false,0,true);
         _tipSprite.addEventListener("mouseOut",outHandler,false,0,true);
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         if(_completeStatus == 0 || _completeStatus == 1)
         {
            _tip.visible = true;
         }
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         _tip.visible = false;
      }
      
      public function refreshView(param1:AvatarCollectionUnitVo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(param1)
         {
            _loc3_ = param1.totalItemList.length;
            _loc2_ = param1.totalActivityItemCount;
            if(_loc2_ < _loc3_ / 2)
            {
               _completeStatus = 0;
               _tip.refreshView(param1,1);
            }
            else if(_loc2_ == _loc3_)
            {
               _completeStatus = 2;
            }
            else
            {
               _completeStatus = 1;
               _tip.refreshView(param1,2);
            }
         }
         else
         {
            _completeStatus = -1;
         }
         var _loc6_:int = 0;
         var _loc5_:* = _propertyCellList;
         for each(var _loc4_ in _propertyCellList)
         {
            _loc4_.refreshView(param1,_completeStatus);
         }
         _allPropertyView.refreshView();
      }
      
      private function removeEvent() : void
      {
         _tipSprite.removeEventListener("mouseOver",overHandler);
         _tipSprite.removeEventListener("mouseOut",outHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _propertyCellList = null;
         _tip = null;
         _tipSprite = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
