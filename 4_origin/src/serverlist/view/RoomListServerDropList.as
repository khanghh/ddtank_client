package serverlist.view
{
   import com.pickgliss.ui.ComponentFactory;
   
   public class RoomListServerDropList extends ServerDropList
   {
       
      
      public function RoomListServerDropList()
      {
         super();
      }
      
      override protected function initView() : void
      {
         _cb = ComponentFactory.Instance.creat("serverlist.room.DropListCombo");
         addChild(_cb);
      }
   }
}
