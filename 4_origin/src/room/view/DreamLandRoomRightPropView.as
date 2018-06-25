package room.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   
   public class DreamLandRoomRightPropView extends RoomRightPropView
   {
       
      
      public function DreamLandRoomRightPropView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         if(_secBg)
         {
            ObjectUtils.disposeObject(_secBg);
         }
         _secBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.roomRightPropView.secbg2");
         addChildAt(_secBg,getChildIndex(_bg) + 1);
      }
      
      public function set blessInfo(value:*) : void
      {
      }
   }
}
