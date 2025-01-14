import { Text } from "@mantine/core";
import { Assist } from "../../../store/doors";

const statusColors: Record<Assist["status"], string> = {
    accepted: "green",
    open: "red",
    taken: "orange"
}

export function AssistStatus ({ status }: {status: Assist["status"]}) {
    return <Text sx={{
        color: statusColors[status]
    }}>
        {status.toLocaleUpperCase()}
    </Text>
}