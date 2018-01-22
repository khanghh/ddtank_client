package ddt.view.im
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.IMManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import im.PresentRecordInfo;
   
   public class MessageBoxItem extends Sprite implements Disposeable
   {
      
      public static const DELETE:String = "delete";
       
      
      private var _recordInfo:PresentRecordInfo;
      
      private var _hotArea:Sprite;
      
      private var _stateImg:ScaleFrameImage;
      
      private var _sex:ScaleFrameImage;
      
      private var _name:FilterFrameText;
      
      private var _delete:SimpleBitmapButton;
      
      private var _newSign:Bitmap;
      
      private var _team:Bitmap;
      
      private var _PlayerInfo:PlayerInfo;
      
      public function MessageBoxItem()
      {
         super();
         _stateImg = ComponentFactory.Instance.creatComponentByStylename("messageboxItem.bg");
         _sex = ComponentFactory.Instance.creatComponentByStylename("core.im.CityIcon");
         _team = ComponentFactory.Instance.creatBitmap("asset.IM.teamBtn");
         PositionUtils.setPos(_team,"teamIconPos");
         _name = ComponentFactory.Instance.creatComponentByStylename("messageboxItem.name");
         _newSign = ComponentFactory.Instance.creatBitmap("asset.messagebox.newSign");
         _delete = ComponentFactory.Instance.creatComponentByStylename("messageboxItem.delete");
         _hotArea = new Sprite();
         _hotArea.graphics.beginFill(0,0);
         _hotArea.graphics.drawRect(0,0,_stateImg.width,_stateImg.height);
         _hotArea.graphics.endFill();
         addChild(_hotArea);
         addChild(_stateImg);
         addChild(_sex);
         addChild(_name);
         addChild(_newSign);
         addChild(_delete);
         addChild(_team);
         PositionUtils.setPos(_sex,"messagebox.sexPos");
         _delete.visible = false;
         addEventListener("mouseOut",__outHandler);
         addEventListener("mouseOver",__overHandler);
         _delete.addEventListener("click",__deleteHandler);
      }
      
      override public function get height() : Number
      {
         return _stateImg.height;
      }
      
      protected function __deleteHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         IMManager.Instance.removePrivateMessage(_recordInfo.id);
         dispatchEvent(new Event("delete"));
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         if(_recordInfo.exist == 2)
         {
            _stateImg.visible = true;
            _stateImg.setFrame(2);
         }
         else
         {
            _stateImg.visible = false;
         }
         _delete.visible = false;
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         _delete.visible = true;
         _stateImg.visible = true;
         _stateImg.setFrame(1);
      }
      
      public function set recordInfo(param1:PresentRecordInfo) : void
      {
         _recordInfo = param1;
         if(param1.exist == 2)
         {
            _newSign.visible = true;
            _stateImg.visible = true;
            _stateImg.setFrame(2);
         }
         else
         {
            _newSign.visible = false;
            _stateImg.visible = false;
         }
         if(param1.teamId)
         {
            _sex.visible = false;
            _team.visible = true;
            _name.text = PlayerManager.Instance.Self.teamName;
         }
         else
         {
            _PlayerInfo = PlayerManager.Instance.findPlayer(param1.id);
            if(!_PlayerInfo.NickName)
            {
               SocketManager.Instance.out.sendItemEquip(param1.id,false);
               _PlayerInfo.addEventListener("propertychange",__infoHandler);
            }
            else
            {
               _sex.setFrame(!!_PlayerInfo.Sex?1:2);
               _sex.visible = true;
               _team.visible = false;
               _name.text = _PlayerInfo.NickName;
            }
         }
      }
      
      protected function __infoHandler(param1:Event) : void
      {
         _PlayerInfo.removeEventListener("propertychange",__infoHandler);
         _sex.setFrame(!!_PlayerInfo.Sex?1:2);
         _name.text = _PlayerInfo.NickName;
      }
      
      public function get recordInfo() : PresentRecordInfo
      {
         return _recordInfo;
      }
      
      public function dispose() : void
      {
         removeEventListener("mouseOut",__outHandler);
         removeEventListener("mouseOver",__overHandler);
         _delete.removeEventListener("click",__deleteHandler);
         _recordInfo = null;
         _PlayerInfo = null;
         if(_hotArea)
         {
            ObjectUtils.disposeObject(_hotArea);
         }
         _hotArea = null;
         if(_stateImg)
         {
            ObjectUtils.disposeObject(_stateImg);
         }
         _stateImg = null;
         if(_sex)
         {
            ObjectUtils.disposeObject(_sex);
         }
         _sex = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_delete)
         {
            ObjectUtils.disposeObject(_delete);
         }
         _delete = null;
         if(_newSign)
         {
            ObjectUtils.disposeObject(_newSign);
         }
         _newSign = null;
         if(_team)
         {
            ObjectUtils.disposeObject(_team);
         }
         _team = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
