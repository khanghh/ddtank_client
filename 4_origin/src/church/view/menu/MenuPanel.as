package church.view.menu
{
   import church.ChurchManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MenuPanel extends Sprite
   {
      
      public static const STARTPOS:int = 10;
      
      public static const STARTPOS_OFSET:int = 18;
      
      public static const GUEST_X:int = 9;
      
      public static const THIS_X_OFSET:int = 95;
      
      public static const THIS_Y_OFSET:int = 55;
       
      
      private var _info:PlayerInfo;
      
      private var _kickGuest:MenuItem;
      
      private var _blackGuest:MenuItem;
      
      private var _bg:ScaleBitmapImage;
      
      public function MenuPanel()
      {
         super();
         _bg = ComponentFactory.Instance.creat("church.weddingRoom.guestListMenuBg");
         addChildAt(_bg,0);
         var startPos:* = 10;
         _kickGuest = new MenuItem(LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.exitRoom"));
         _kickGuest.x = 9;
         _kickGuest.y = startPos;
         startPos = Number(startPos + 18);
         _kickGuest.addEventListener("menuClick",__menuClick);
         addChild(_kickGuest);
         _blackGuest = new MenuItem(LanguageMgr.GetTranslation("tank.view.im.AddBlackListFrame.btnText"));
         _blackGuest.x = 9;
         _blackGuest.y = startPos;
         startPos = Number(startPos + 18);
         _blackGuest.addEventListener("menuClick",__menuClick);
         addChild(_blackGuest);
         graphics.beginFill(0,0);
         graphics.drawRect(-3000,-3000,6000,6000);
         graphics.endFill();
         addEventListener("click",__mouseClick);
      }
      
      public function set playerInfo(value:PlayerInfo) : void
      {
         _info = value;
      }
      
      private function __mouseClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         hide();
      }
      
      private function __menuClick(event:Event) : void
      {
         if(ChurchManager.instance.currentRoom.status == "wedding_ing")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.menu.MenuPanel.menuClick"));
            return;
         }
         if(_info)
         {
            var _loc2_:* = event.currentTarget;
            if(_kickGuest !== _loc2_)
            {
               if(_blackGuest === _loc2_)
               {
                  SocketManager.Instance.out.sendChurchForbid(_info.ID);
               }
            }
            else
            {
               SocketManager.Instance.out.sendChurchKick(_info.ID);
            }
         }
      }
      
      public function show() : void
      {
         var pos:* = null;
         LayerManager.Instance.addToLayer(this,2);
         if(stage && parent)
         {
            pos = parent.globalToLocal(new Point(stage.mouseX,stage.mouseY));
            this.x = pos.x;
            this.y = pos.y;
            if(x + 95 > stage.stageWidth)
            {
               this.x = x - 95;
            }
            if(y + 55 > stage.stageHeight)
            {
               y = stage.stageHeight - 55;
            }
         }
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("click",__mouseClick);
         _blackGuest.removeEventListener("menuClick",__menuClick);
         _info = null;
         if(_kickGuest && _kickGuest.parent)
         {
            _kickGuest.parent.removeChild(_kickGuest);
         }
         if(_kickGuest)
         {
            _kickGuest.dispose();
         }
         _kickGuest = null;
         if(_blackGuest && _blackGuest.parent)
         {
            _blackGuest.parent.removeChild(_blackGuest);
         }
         if(_blackGuest)
         {
            _blackGuest.dispose();
         }
         _blackGuest = null;
         if(_bg)
         {
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
            _bg.dispose();
         }
         _bg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
