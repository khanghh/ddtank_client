package ddt.view.buff
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.view.buff.buffButton.BuffButton;
   import ddt.view.buff.buffButton.GrowHelpBuffButton;
   import ddt.view.buff.buffButton.LabyrinthBuffButton;
   import ddt.view.buff.buffButton.PayBuffButton;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import oldplayergetticket.GetTicketManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class BuffControl extends Sprite implements Disposeable
   {
       
      
      private var _buffData:DictionaryData;
      
      private var _buffList:HBox;
      
      private var _buffBtnArr:Array;
      
      private var _str:String;
      
      private var _spacing:int;
      
      private var _growHelpBuff:GrowHelpBuffButton;
      
      private var _payBuff:PayBuffButton;
      
      private var _labyrinthBuff:LabyrinthBuffButton;
      
      private var _expBlessedIcon:ScaleFrameImage;
      
      private var _getTicketBtn:BaseButton;
      
      private var _attestBtn:ScaleFrameImage;
      
      public function BuffControl(param1:String = "", param2:int = 0){super();}
      
      public static function isPayBuff(param1:BuffInfo) : Boolean{return false;}
      
      private function init() : void{}
      
      public function set boxSpacing(param1:int) : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function initBuffButtons() : void{}
      
      private function addAttestBuff() : void{}
      
      protected function __onAttestBtnClick(param1:MouseEvent) : void{}
      
      private function addRegressTicketBuff() : void{}
      
      private function __addGetTicketBtn(param1:PkgEvent) : void{}
      
      private function addOldPlayerGetTicketBtn() : void{}
      
      protected function __onGetTicketClick(param1:MouseEvent) : void{}
      
      private function addExpBuff() : void{}
      
      protected function __addExpBlessedBtn(param1:PkgEvent) : void{}
      
      private function addGrowHelpIcon() : void{}
      
      private function addpayBuffIcon() : void{}
      
      private function addLabyrinthBuff() : void{}
      
      public function setInfo(param1:DictionaryData) : void{}
      
      private function __addBuff(param1:DictionaryEvent) : void{}
      
      private function setBuffButtonInfo(param1:int, param2:BuffInfo) : void{}
      
      private function __removeBuff(param1:DictionaryEvent) : void{}
      
      private function __updateBuff(param1:DictionaryEvent) : void{}
      
      public function set CanClick(param1:Boolean) : void{}
      
      private function deleteGetTicketBtn() : void{}
      
      private function deleteExpBlessedBtn() : void{}
      
      public function dispose() : void{}
      
      public function get buffBtnArr() : Array{return null;}
   }
}
