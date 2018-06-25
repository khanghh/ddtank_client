package room.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.horse.HorseSkillCell;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import horse.HorseManager;
   
   public class RoomPropCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _container:HorseSkillCell;
      
      protected var _skillId:int;
      
      protected var _isself:Boolean;
      
      protected var _place:int;
      
      private var _xyz:FilterFrameText;
      
      public function RoomPropCell(isself:Boolean, place:int, isHorse:Boolean = false)
      {
         _isself = isself;
         _place = place;
         if(_isself)
         {
            if(isHorse)
            {
               _bg = ComponentFactory.Instance.creatBitmap("asset.horse.skillFrame.selfCellBgAsset");
               _xyz = ComponentFactory.Instance.creatComponentByStylename("horse.skillFrame.cellZXC");
            }
            else
            {
               _bg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.selfCellBgAsset");
               _xyz = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.cellZXC");
            }
            switch(int(place))
            {
               case 0:
                  _xyz.text = "z";
                  break;
               case 1:
                  _xyz.text = "x";
                  break;
               case 2:
                  _xyz.text = "c";
            }
            addChild(_bg);
            addChild(_xyz);
         }
         else
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.storeCellBgAsset");
            addChild(_bg);
         }
         super();
         initEvent();
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__mouseClick);
         addEventListener("mouseOver",__mouseOver);
         addEventListener("mouseOut",__mouseOut);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__mouseClick);
         removeEventListener("mouseOver",__mouseOver);
         removeEventListener("mouseOut",__mouseOut);
      }
      
      public function set skillId(skillId:int) : void
      {
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
            _container = null;
         }
         buttonMode = false;
         _skillId = skillId;
         if(_skillId == 0)
         {
            return;
         }
         buttonMode = true;
         _container = new HorseSkillCell(_skillId,false,true);
         _container.x = -3;
         _container.y = -3;
         addChild(_container);
      }
      
      protected function __mouseClick(evt:MouseEvent) : void
      {
         var tmpPlace:int = 0;
         if(_skillId == 0)
         {
            return;
         }
         SoundManager.instance.play("008");
         if(_isself)
         {
            SocketManager.Instance.out.sendHorseTakeUpDownSkill(_skillId,0);
         }
         else
         {
            if(HorseManager.instance.isSkillHasEquip(_skillId))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillCannotEquipSame"));
               return;
            }
            tmpPlace = HorseManager.instance.takeUpSkillPlace;
            if(tmpPlace == 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillEquipMax"));
               return;
            }
            SocketManager.Instance.out.sendHorseTakeUpDownSkill(_skillId,tmpPlace);
         }
      }
      
      private function __mouseOver(evt:MouseEvent) : void
      {
      }
      
      private function __mouseOut(evt:MouseEvent) : void
      {
      }
      
      override public function get width() : Number
      {
         return 40;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_xyz)
         {
            ObjectUtils.disposeObject(_xyz);
         }
         _xyz = null;
         if(_container)
         {
            _container.dispose();
         }
         _container = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
