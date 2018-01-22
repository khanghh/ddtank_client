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
      
      public function FightLibAlertView(param1:String, param2:String = null, param3:Function = null, param4:String = null, param5:Function = null, param6:Boolean = true, param7:Boolean = false, param8:Array = null)
      {
         _okLabel = LanguageMgr.GetTranslation("ok");
         _cancelLabel = LanguageMgr.GetTranslation("tank.command.fightLibCommands.script.MeasureScree.watchAgain");
         super();
         _infoStr = param1;
         if(param2)
         {
            _okLabel = param2;
         }
         _okFun = param3;
         if(param4)
         {
            _cancelLabel = param4;
         }
         _cancelFun = param5;
         _showOkBtn = param6;
         _showCancelBtn = param7;
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
         if(param8 != null)
         {
            ShowWeaponIcon(param8);
         }
      }
      
      private function ShowWeaponIcon(param1:Array) : void
      {
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         _WeaponCellArr = [];
         var _loc6_:int = param1.length;
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc4_ = new Sprite();
            _loc4_.graphics.beginFill(16777215,0);
            _loc4_.graphics.drawRect(0,0,60,60);
            _loc4_.graphics.endFill();
            _loc7_ = ItemManager.Instance.getTemplateById(param1[_loc8_]);
            _loc5_ = new BaseCell(_loc4_,_loc7_,true,false);
            _loc5_.x = 30 + _loc8_ * 70;
            _loc5_.y = 50;
            addChild(_loc5_);
            _WeaponCellArr.push(_loc5_);
            _loc3_ = _loc7_.Name.slice(2);
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("fightLib.WeaponNameField");
            _loc2_.x = 58 + _loc8_ * 70;
            _loc2_.y = 110;
            _loc2_.text = _loc3_;
            addChild(_loc2_);
            _loc8_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         if(_WeaponCellArr != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _WeaponCellArr.length)
            {
               _WeaponCellArr[_loc1_].dispose();
               _loc1_++;
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
      
      public function set alert(param1:String) : void
      {
         _txt.text = param1;
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
      
      private function __cancelClicked(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_cancelFun != null)
         {
            _cancelFun();
         }
      }
      
      private function __submitClicked(param1:MouseEvent) : void
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
