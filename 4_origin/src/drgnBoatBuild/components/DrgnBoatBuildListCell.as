package drgnBoatBuild.components
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import drgnBoatBuild.DrgnBoatBuildCellInfo;
   import drgnBoatBuild.DrgnBoatBuildManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class DrgnBoatBuildListCell extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _bg:Image;
      
      private var _light:ScaleBitmapImage;
      
      private var _levelIcon:LevelIcon;
      
      private var _nameText:FilterFrameText;
      
      private var _canIcon:Bitmap;
      
      private var _vipName:GradientText;
      
      private var _info:DrgnBoatBuildCellInfo;
      
      private var _selected:Boolean = false;
      
      public function DrgnBoatBuildListCell()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.cellBg");
         addChild(_bg);
         _light = ComponentFactory.Instance.creatComponentByStylename("drgnboatBuild.light");
         _light.visible = false;
         addChild(_light);
         _levelIcon = new LevelIcon();
         PositionUtils.setPos(_levelIcon,"drgnBoatBuild.levelIconPos");
         _levelIcon.setSize(1);
         addChild(_levelIcon);
         _nameText = ComponentFactory.Instance.creat("drgnBoatBuild.list.nameTxt");
         addChild(_nameText);
         _canIcon = ComponentFactory.Instance.creatBitmap("drgnBoatBuild.canIcon");
         _canIcon.visible = false;
         addChild(_canIcon);
      }
      
      private function initEvents() : void
      {
         addEventListener("mouseOver",__itemOver);
         addEventListener("mouseOut",__itemOut);
         addEventListener("click",__itemClick);
      }
      
      protected function __itemClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         DrgnBoatBuildManager.instance.selectedId = _info.id;
         SocketManager.Instance.out.updateDrgnBoatBuildInfo(_info.id);
      }
      
      protected function __itemOut(event:MouseEvent) : void
      {
         if(!isFriendSelected())
         {
            _light.visible = false;
         }
      }
      
      protected function __itemOver(event:MouseEvent) : void
      {
         _light.visible = true;
      }
      
      private function removeEvents() : void
      {
         removeEventListener("mouseOver",__itemOver);
         removeEventListener("mouseOut",__itemOut);
         removeEventListener("click",__itemClick);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_light);
         _light = null;
         ObjectUtils.disposeObject(_levelIcon);
         _levelIcon = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_canIcon);
         _canIcon = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vipName);
         _vipName = null;
      }
      
      private function isFriendSelected() : Boolean
      {
         if(DrgnBoatBuildManager.instance.selectedId == _info.id)
         {
            return true;
         }
         return false;
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
         _bg.setFrame(index % 2 + 1);
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(value:*) : void
      {
         _info = value;
         update();
      }
      
      private function update() : void
      {
         _levelIcon.setInfo(_info.playerinfo.Grade,_info.playerinfo.ddtKingGrade,_info.playerinfo.Repute,_info.playerinfo.WinCount,_info.playerinfo.TotalCount,_info.playerinfo.FightPower,_info.playerinfo.Offer,true);
         if(_info.playerinfo.IsVIP)
         {
            if(_vipName == null)
            {
               _vipName = VipController.instance.getVipNameTxt(100);
               addChild(_vipName);
            }
            _vipName.x = _nameText.x;
            _vipName.y = _nameText.y;
            _vipName.text = _info.playerinfo.NickName;
            _vipName.visible = true;
            _nameText.visible = false;
         }
         else
         {
            if(_vipName)
            {
               _vipName.visible = false;
            }
            _nameText.visible = true;
         }
         _nameText.text = _info.playerinfo.NickName;
         _canIcon.visible = _info.canBuild;
         if(isFriendSelected())
         {
            _light.visible = true;
         }
         else
         {
            _light.visible = false;
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
