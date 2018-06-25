package fightLib.view
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class FightLibAlertView extends Sprite implements Disposeable
   {
      
      private static const ButtonToCenter:int = 8;
       
      
      private var _background:DisplayObject;
      
      private var _girlImage:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _infoStr:String;
      
      private var _okLabel:String;
      
      private var _okBtn:TextButton;
      
      private var _okFun:Function;
      
      private var _cancelLabel:String;
      
      private var _cancelBtn:TextButton;
      
      private var _cancelFun:Function;
      
      private var _showOkBtn:Boolean;
      
      private var _showCancelBtn:Boolean;
      
      private var _centerPosition:Point;
      
      private var _WeaponCellArr:Array;
      
      public function FightLibAlertView(infoString:String, okLabel:String = null, okFun:Function = null, cancelLabel:String = null, cancelFun:Function = null, showOkBtn:Boolean = true, showCancelBtn:Boolean = false, weaponArr:Array = null)
      {
         _okLabel = LanguageMgr.GetTranslation("ok");
         _cancelLabel = LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.watchAgain");
         super();
         _infoStr = infoString;
         if(okLabel)
         {
            _okLabel = okLabel;
         }
         _okFun = okFun;
         if(cancelLabel)
         {
            _cancelLabel = cancelLabel;
         }
         _cancelFun = cancelFun;
         _showOkBtn = showOkBtn;
         _showCancelBtn = showCancelBtn;
         configUI();
         addEvent();
         if(!_showCancelBtn)
         {
            _okBtn.x = _centerPosition.x - _okBtn.width / 2;
         }
         else
         {
            _okBtn.x = _centerPosition.x - _okBtn.width - 8;
            _cancelBtn.x = _centerPosition.x + 8;
         }
         var _loc9_:* = _centerPosition.y;
         _cancelBtn.y = _loc9_;
         _okBtn.y = _loc9_;
         _okBtn.visible = _showOkBtn;
         _cancelBtn.visible = _showCancelBtn;
         if(weaponArr != null)
         {
            ShowWeaponIcon(weaponArr);
         }
      }
      
      private function ShowWeaponIcon(_arr:Array) : void
      {
         var cardTempInfo:* = null;
         var i:int = 0;
         var s:* = null;
         var cell:* = null;
         var _NameTxt:* = null;
         var _WeaponNameField:* = null;
         _WeaponCellArr = [];
         var Max:int = _arr.length;
         for(i = 0; i < Max; )
         {
            s = new Sprite();
            s.graphics.beginFill(16777215,0);
            s.graphics.drawRect(0,0,60,60);
            s.graphics.endFill();
            cardTempInfo = ItemManager.Instance.getTemplateById(_arr[i]);
            cell = new BaseCell(s,cardTempInfo,true,false);
            cell.x = 30 + i * 70;
            cell.y = 50;
            addChild(cell);
            _WeaponCellArr.push(cell);
            _NameTxt = cardTempInfo.Name.slice(2);
            _WeaponNameField = ComponentFactory.Instance.creatComponentByStylename("fightLib.WeaponNameField");
            _WeaponNameField.x = 58 + i * 70;
            _WeaponNameField.y = 110;
            _WeaponNameField.text = _NameTxt;
            addChild(_WeaponNameField);
            i++;
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         if(_WeaponCellArr != null)
         {
            for(i = 0; i < _WeaponCellArr.length; )
            {
               _WeaponCellArr[i].dispose();
               i++;
            }
         }
         ObjectUtils.disposeAllChildren(this);
         _background = null;
         _girlImage = null;
         _cancelBtn = null;
         _cancelFun = null;
         _okBtn = null;
         _okFun = null;
         _txt = null;
         _WeaponCellArr = null;
      }
      
      public function show() : void
      {
         x = StageReferance.stageWidth - width >> 1;
         y = StageReferance.stageHeight - height >> 1;
         _txt.text = _infoStr;
         updataWeaponIcon();
         LayerManager.Instance.addToLayer(this,4);
      }
      
      private function updataWeaponIcon() : void
      {
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set alert(val:String) : void
      {
         _txt.text = val;
      }
      
      public function get alert() : String
      {
         return _txt.text;
      }
      
      private function configUI() : void
      {
         _centerPosition = ComponentFactory.Instance.creatCustomObject("fithtLib.Alert.CenterPosition");
         _background = ComponentFactory.Instance.creatComponentByStylename("fightLib.Game.GirlGuildBack");
         addChild(_background);
         _girlImage = ComponentFactory.Instance.creatBitmap("fightLib.Game.GirlGuild.Girl");
         _girlImage.scaleX = -0.6;
         _girlImage.scaleY = 0.6;
         addChild(_girlImage);
         _txt = ComponentFactory.Instance.creatComponentByStylename("fightLib.Alert.AlertField");
         addChild(_txt);
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("fightLib.Alert.SubmitButton");
         if(_okLabel != null)
         {
            _okBtn.text = _okLabel;
         }
         else
         {
            _okBtn.text = LanguageMgr.GetTranslation("ok");
         }
         addChild(_okBtn);
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("fightLib.Alert.CancelButton");
         if(_cancelLabel != null)
         {
            _cancelBtn.text = _cancelLabel;
         }
         else
         {
            _cancelBtn.text = LanguageMgr.GetTranslation("cancel");
         }
         addChild(_cancelBtn);
      }
      
      private function addEvent() : void
      {
         _okBtn.addEventListener("click",__submitClicked);
         _cancelBtn.addEventListener("click",__cancelClicked);
      }
      
      private function __cancelClicked(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_cancelFun != null)
         {
            _cancelFun();
         }
      }
      
      private function __submitClicked(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_okFun != null)
         {
            _okFun();
         }
      }
      
      private function removeEvent() : void
      {
         _okBtn.removeEventListener("click",__submitClicked);
         _cancelBtn.removeEventListener("click",__cancelClicked);
      }
   }
}
