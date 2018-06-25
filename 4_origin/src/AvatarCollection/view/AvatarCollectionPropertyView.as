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
         var i:int = 0;
         var tmp:* = null;
         _propertyCellList = new Vector.<AvatarCollectionPropertyCell>();
         _allPropertyView = new AvatarCollectionAllPropertyView();
         _allPropertyView.x = 274;
         _allPropertyView.y = 0;
         addChild(_allPropertyView);
         for(i = 0; i < 7; )
         {
            tmp = new AvatarCollectionPropertyCell(i);
            tmp.x = int(i / 4) * 110;
            tmp.y = i % 4 * 25;
            addChild(tmp);
            _propertyCellList.push(tmp);
            i++;
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
      
      private function overHandler(event:MouseEvent) : void
      {
         if(_completeStatus == 0 || _completeStatus == 1)
         {
            _tip.visible = true;
         }
      }
      
      private function outHandler(event:MouseEvent) : void
      {
         _tip.visible = false;
      }
      
      public function refreshView(data:AvatarCollectionUnitVo) : void
      {
         var totalCount:int = 0;
         var activityCount:int = 0;
         if(data)
         {
            totalCount = data.totalItemList.length;
            activityCount = data.totalActivityItemCount;
            if(activityCount < totalCount / 2)
            {
               _completeStatus = 0;
               _tip.refreshView(data,1);
            }
            else if(activityCount == totalCount)
            {
               _completeStatus = 2;
            }
            else
            {
               _completeStatus = 1;
               _tip.refreshView(data,2);
            }
         }
         else
         {
            _completeStatus = -1;
         }
         var _loc6_:int = 0;
         var _loc5_:* = _propertyCellList;
         for each(var tmp in _propertyCellList)
         {
            tmp.refreshView(data,_completeStatus);
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
