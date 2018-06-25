package bank{   import bank.analyzer.BankInvestmentDataAnalyzer;   import bank.data.BankInvestmentModel;   import bank.data.BankRecordInfo;   import bank.data.GameBankEvent;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.utils.ClassUtils;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.TimeManager;   import ddt.utils.AssetModuleLoader;   import flash.display.Sprite;   import flash.events.EventDispatcher;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class BankManager extends EventDispatcher   {            public static const BANK_GETINFO:int = 1;            public static const BANK_ADD:int = 2;            public static const BANK_UPDATA:int = 3;            public static const BANK_UPDATE_TASK:int = 4;            public static const BANK_SAVE_OR_GET_VIEW:int = 0;            public static const BANK_SAVE_VIEW:int = 1;            public static const BANK_GET_VIEW:int = 2;            public static const BANK_SAVE_RECORD_VIEW:int = 3;            private static var _instance:BankManager;                   private var _model:BankInvestmentModel;            private var _totleSaveMoney:int = 0;            private var _totleProfitMoney:int = 0;            private var _icon:BaseButton;            public function BankManager($inner:inner) { super(null); }
            public static function get instance() : BankManager { return null; }
            public function setup() : void { }
            private function showFrame() : void { }
            public function showIcon() : void { }
            private function __bankInfo(e:PkgEvent) : void { }
            private function getBankInfo(pkg:PackageIn) : void { }
            private function addBankInfo(pkg:PackageIn) : void { }
            private function UpdateBankInfo(pkg:PackageIn) : void { }
            public function show() : void { }
            public function onDataComplete(analyzer:BankInvestmentDataAnalyzer) : void { }
            public function get totleSaveMoney() : int { return 0; }
            public function get totleProfitMoney() : int { return 0; }
            public function getProfitNum(info:BankRecordInfo, isExpect:Boolean = false, getNum:int = 0, isAchieve:Boolean = true) : int { return 0; }
            public function isAchieve(info:BankRecordInfo) : Boolean { return false; }
            public function get model() : BankInvestmentModel { return null; }
   }}class inner{          function inner() { super(); }
}