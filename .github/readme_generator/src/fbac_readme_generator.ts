import fs from "fs";
import { FileLanguage, ReadmeGenerator } from "../../../../generator/src/readme_generator";

/**
 * 作成状況データを示す構造体
 */
interface CreationStatusData {
    /** 作成済み */
    done: CharacterData[],

    /** 作成中 */
    in_progress: CharacterData[],

    /** 作成予定 */
    planned: CharacterData[]
}

/**
 * 作成状況におけるキャラクターのデータを示す構造体
 */
interface CharacterData {
    /** キャラクターの名前 */
    character_name: {
        /** 名前 */
        first_name: LanguageData,

        /** 苗字 */
        last_name: LanguageData
    },

    /** 衣装の名前（あれば） */
    costume_name: LanguageData | null,

    /** そのキャラクターを作ること示したissue番号。該当のissueが存在しない場合は0にする。 */
    issue_number: number
}

/**
 * 作成状況における異なる言語での表示名を示す構造体
 */
interface LanguageData {
    /** 英語 */
    en: string,

    /** 日本語 */
    jp: string
}

class FBACReadmeGenerator extends ReadmeGenerator {
    /**
     * コンストラクタ
     * @param repositoryName 対象のレポジトリ名
     */
    constructor(repositoryName: string) {
        super(repositoryName, "../../../generator");
    }

    protected onInjectTagFound(tagName: string, fileLanguage: FileLanguage): string {
        let text: string = super.onInjectTagFound(tagName, fileLanguage);
        if(tagName == "creation_status" && this.caches[`${tagName}_${fileLanguage}`] == undefined) {
            if(fs.existsSync("./src/creation_status.json")) {
                try {
                    let characterData: CreationStatusData = JSON.parse(fs.readFileSync("./src/creation_status.json", {encoding: "utf-8"}));
                    if(fs.existsSync(`../README_templates/creation_status/done/${fileLanguage}.md`)) text = fs.readFileSync(`../README_templates/creation_status/done/${fileLanguage}.md`, {encoding: "utf-8"});
                    else text = `<!-- ERROR: "creation_status/done/${fileLanguage}.md" doesn't exist -->\n`;
                    text += "\n";
                    if(characterData.done.length > 0) {
                        characterData.done.forEach((character: CharacterData) => {
                            switch(fileLanguage) {
                                case "en":
                                    text += `- ${character.character_name.first_name.en} ${character.character_name.last_name.en}${character.costume_name != null ? ` (${character.costume_name.en})` : ""}\n`;
                                    break;
                                case "jp":
                                    text += `- ${character.character_name.last_name.jp}${character.character_name.first_name.jp}${character.costume_name != null ? `（${character.costume_name.jp}）` : ""}\n`;
                                    break;
                            }
                        });
                    }
                    else text += `${fileLanguage == "en" ? "(There is no character available now.)" : "（現在利用可能なキャラクターはいません。）"}\n`;
                    text += "\n";
                    if(fs.existsSync(`../README_templates/creation_status/in_progress/${fileLanguage}.md`)) text += fs.readFileSync(`../README_templates/creation_status/in_progress/${fileLanguage}.md`, {encoding: "utf-8"});
                    else text += `<!-- ERROR: "creation_status/in_progress/${fileLanguage}.md" doesn't exist -->\n`;
                    text += "\n";
                    if(characterData.in_progress.length > 0) {
                        characterData.in_progress.forEach((character: CharacterData) => {
                            switch(fileLanguage) {
                                case "en":
                                    text += `- ${character.character_name.first_name.en} ${character.character_name.last_name.en}${character.costume_name != null ? ` (${character.costume_name.en})` : ""}${character.issue_number >= 1 && character.issue_number % 1 == 0 ? ` ([#${character.issue_number}](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/${character.issue_number}))` : ""}\n`;
                                    break;
                                case "jp":
                                    text += `- ${character.character_name.last_name.jp}${character.character_name.first_name.jp}${character.costume_name != null ? `（${character.costume_name.jp}）` : ""}${character.issue_number >= 1 && character.issue_number % 1 == 0 ? `（[#${character.issue_number}](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/${character.issue_number})）` : ""}\n`;
                                    break;
                            }
                        });
                    }
                    else text += `${fileLanguage == "en" ? "(There is no avatar currently being created.)" : "（現在作成中のアバターはありません。）"}\n`;
                    text += "\n";
                    if(fs.existsSync(`../README_templates/creation_status/planned/${fileLanguage}.md`)) text += fs.readFileSync(`../README_templates/creation_status/planned/${fileLanguage}.md`, {encoding: "utf-8"});
                    else text += `<!-- ERROR: "creation_status/planned/${fileLanguage}.md" doesn't exist -->\n`;
                    text += "\n";
                    if(characterData.planned.length > 0) {
                        characterData.planned.forEach((character: CharacterData) => {
                            switch(fileLanguage) {
                                case "en":
                                    text += `- ${character.character_name.first_name.en} ${character.character_name.last_name.en}${character.costume_name != null ? ` (${character.costume_name.en})` : ""}${character.issue_number >= 1 && character.issue_number % 1 == 0 ? ` ([#${character.issue_number}](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/${character.issue_number}))` : ""}\n`;
                                    break;
                                case "jp":
                                    text += `- ${character.character_name.last_name.jp}${character.character_name.first_name.jp}${character.costume_name != null ? `（${character.costume_name.jp}）` : ""}${character.issue_number >= 1 && character.issue_number % 1 == 0 ? `（[#${character.issue_number}](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/${character.issue_number})）` : ""}\n`;
                                    break;
                            }
                        });
                        text = text.substring(0, text.length - 1);
                    }
                    else text += `${fileLanguage == "en" ? "(There is no avatar planned to be created.)" : "（作成予定のアバターはありません。）"}`;
                }
                catch {
                    return "<!-- ERROR: Failed to parse \"character_status.json\" -->\n";
                }
            }
            else {
                return "<!-- ERROR: \"character_status.json\" doesn't exist -->\n";
            }

            this.caches[`${tagName}_${fileLanguage}`] = text;
        }
        return text;
    }
}

if(require.main === module) {
    new FBACReadmeGenerator(process.argv[3]).main();
}